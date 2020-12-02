# frozen_string_literal: true

# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

desc "A tool that generates a new client library"

long_desc \
  "A tool that generates a new client library.",
  "",
  "Use this tool to automate the process of generating a new gapic or" \
    " wrapper client. You provide, on the command line, the name of the gem" \
    " to generate. This tool will determine what kind of library is being" \
    " requested, create an appropriate synth script, run the generator to" \
    " generate the library itself, ensure the tests pass, update the kokoro" \
    " configs, and optionally open a pull request for the new library.",
  "",
  "Fields such as description and product URL are filled in from existing" \
    " libraries for the same API, if any are present; otherwise, they are" \
    " given default values. The tool also invokes your editor with the" \
    " generated synth script before running it, so you can make adjustments." \
    " In general, for the first library for any given API, you'll need to" \
    " fill in a number of fields in the script in your editor, but for most" \
    " subsequent libraries, this tool will be able to generate the correct" \
    " synth script using previous scripts as a model."

required_arg :gem_name do
  desc "The full gem name. The type (gapic or wrapper) is inferred from whether the name includes a version."
end

flag :editor do
  default ENV["EDITOR"]
  desc "The path to your editor. Uses the EDITOR environment variable by default."
end
flag :branch_name, "--branch NAME" do
  desc "The name of the branch to use if opening a pull request. Defaults to gen/GEM-NAME."
end
flag :git_remote, "--remote NAME" do
  desc "The name of the git remote to use as the pull request head. If omitted, does not open a pull request."
end

static :replace_me_text, "(REPLACE ME)"

include :exec, e: true
include :fileutils
include :terminal

def run
  require "erb"
  require "fileutils"
  @gem_name = gem_name
  @branch_name = branch_name || "gen/#{@gem_name}"
  @year = Time.now.year
  generate
end

def generate
  clean_output_directory
  puts "\nGathering info...", :bold
  ensure_gh_binary
  ensure_git_binary
  ensure_synthtool
  analyze_gem_name
  determine_defaults
  determine_existing_versions
  lookup_precedents
  fill_type_specific_fields
  create_optional_sections
  puts "\nGenerating synth script...", :bold
  start_branch if git_remote
  populate_initial_synth_script
  edit_synth_script
  puts "\nGenerating library...", :bold
  generate_lib
  puts "\nTesting library...", :bold
  test_lib
  puts "\nGenerating configs...", :bold
  update_configs
  finish_branch if git_remote
  puts "\nSuccessful", :bold, :green
end

def clean_output_directory
  logger.info "Clearing out directory #{@gem_name}"
  FileUtils.rm_rf @gem_name
end

def ensure_gh_binary
  result = exec ["gh", "--version"], out: :capture, e: false
  match = /^gh version (\d+)\.(\d+)\.(\d+)/.match result.captured_out.to_s
  if !result.success? || !match
    error "gh not installed.",
          "See https://cli.github.com/manual/installation for installation instructions."
  end
  version_val = match[1].to_i * 1_000_000 + match[2].to_i * 1000 + match[3].to_i
  version_str = "#{match[1]}.#{match[2]}.#{match[3]}"
  if version_val < 1_000_000
    error "gh version 1.0 or later required but #{version_str} found.",
          "See https://cli.github.com/manual/installation for installation instructions."
  end
  logger.info "gh version #{version_str} found"
end

def ensure_git_binary
  result = exec ["git", "--version"], out: :capture, e: false
  match = /^git version (\d+)\.(\d+)\.(\d+)/.match result.captured_out.to_s
  if !result.success? || !match
    error "git not installed.",
          "See https://git-scm.com/downloads for installation instructions."
  end
  version_val = match[1].to_i * 1_000_000 + match[2].to_i * 1000 + match[3].to_i
  version_str = "#{match[1]}.#{match[2]}.#{match[3]}"
  if version_val < 2_022_000
    error "git version 2.22 or later required but #{version_str} found.",
          "See https://git-scm.com/downloads for installation instructions."
  end
  logger.info "git version #{version_str} found"
end

def ensure_synthtool
  result = exec ["python", "--version"], out: :capture, e: false
  match = /^Python (\d+)\.(\d+)\.(\d+)/.match result.captured_out.to_s
  error "Python 3 not installed." if !result.success? || !match
  version_val = match[1].to_i * 1_000_000 + match[2].to_i * 1000 + match[3].to_i
  version_str = "#{match[1]}.#{match[2]}.#{match[3]}"
  error "Python 3.6 or later required but #{version_str} found." if version_val < 3_6_000
  result = exec ["python", "-m", "pip", "list", "--user", "--format=freeze"], out: :capture, e: false
  error "Pip doesn't seem to be present" unless result.success?
  lines = result.captured_out.to_s.split "\n"
  unless lines.any? { |line| line.start_with? "gcp-synthtool==" }
    error "Synthtool not found.",
          "To install: python -m pip install --user --upgrade git+https://github.com/googleapis/synthtool.git"
  end
  logger.info "Verified synthtool present"
end

def analyze_gem_name
  error "Bad gem name #{@gem_name.inspect}" unless @gem_name.to_s =~ /^[a-z]([a-z0-9_-]*[a-z0-9])?$/
  if @gem_name =~ /^([a-z][a-z0-9_-]*)-(v\d[a-z0-9]*)$/
    @base_gem_name = Regexp.last_match 1
    @api_version = Regexp.last_match 2
    @gen_type = "gapic"
    logger.info "Generating gapic gem #{@base_gem_name}-#{@api_version}"
  else
    @base_gem_name = @gem_name
    @api_version = nil
    @gen_type = "wrapper"
    logger.info "Generating wrapper gem #{@base_gem_name}"
  end
end

def determine_defaults
  gem_shortname = @base_gem_name.sub(/^google-cloud-/, "")
  @api_name = gem_shortname.gsub(/[-_]/, "")
  @api_shortname = @api_name.dup
  @api_id = "#{@api_name}.googleapis.com"
  @service_display_name = gem_shortname.split("_").map(&:capitalize).join " "
  @env_prefix = gem_shortname.gsub("-", "_").upcase
  @service_config_name = "#{@api_name}_grpc_service_config.json"
  @description = replace_me_text
  @product_url = replace_me_text
  @proto_path_base = nil
  @service_override = nil
  @extra_proto_files = ['"google/cloud/common_resources.proto"']
end

def determine_existing_versions
  dirs = Dir.glob "#{@base_gem_name}-v*"
  dirs.delete_if { |dir| dir !~ /^#{@base_gem_name}-v\d[a-z0-9]*$/ }
  dirs.delete_if { |dir| !File.file?("#{dir}/#{dir}.gemspec") || !File.file?("#{dir}/synth.py") }
  @existing_versions = dirs.map { |dir| dir.sub "#{@base_gem_name}-", "" }.sort
  default_version_candidates = @existing_versions.find_all { |v| v =~ /^v\d+$/ }
  default_version_candidates = @existing_versions if default_version_candidates.empty?
  default_gem_version = default_version_candidates.last
  @existing_versions.delete default_gem_version
  @existing_versions.unshift default_gem_version if default_gem_version
  logger.info "Found existing versions: #{@existing_versions}"
end

def lookup_precedents
  @existing_versions.reverse_each do |version|
    synth_file_path = "#{@base_gem_name}-#{version}/synth.py"
    logger.info "Looking for existing settings in #{synth_file_path}..."
    script = File.read synth_file_path
    if script =~ /gapic\.ruby_library\(\n\s+"([^"]*)",/
      @api_name = Regexp.last_match 1
    end
    if script =~ %r{proto_path="([^"]*)/#{version}",}
      @proto_path_base = Regexp.last_match 1
    end
    if script =~ /extra_proto_files=\[([^\]]*)\],/
      @extra_proto_files = Regexp.last_match(1).strip.split(/,\s*|\s+/)
    end
    if script =~ /"ruby-cloud-title":\s*"(.+)",\n/
      name = Regexp.last_match 1
      @service_display_name = name.end_with?(" #{version.capitalize}") ? name[0..-(version.length + 2)] : name
    end
    if script =~ /"ruby-cloud-description":\s*"(.+)",\n/
      @description = Regexp.last_match 1
    end
    if script =~ /"ruby-cloud-env-prefix":\s*"([A-Z0-9_]+)",\n/
      @env_prefix = Regexp.last_match 1
    end
    if script =~ /"ruby-cloud-grpc-service-config":\s*"(.+)",\n/
      path = Regexp.last_match 1
      @service_config_name = File.basename path
    end
    if script =~ /"ruby-cloud-product-url":\s*"(.+)",\n/
      @product_url = Regexp.last_match 1
    end
    if script =~ /"ruby-cloud-api-id":\s*"([a-z0-9._-]+)",\n/
      @api_id = Regexp.last_match 1
    end
    if script =~ /"ruby-cloud-api-shortname":\s*"([a-z0-9_-]+)",\n/
      @api_shortname = Regexp.last_match 1
    end
    if script =~ /"ruby-cloud-service-override":\s*"(.+)",\n/
      @service_override = Regexp.last_match 1
    end
  end
end

def fill_type_specific_fields
  case @gen_type
  when "gapic"
    @title_version = @api_version.capitalize
    @service_config_path = @proto_path_base || "google/cloud/#{@api_name}"
    @service_config_path += "/#{@api_version}/#{@service_config_name}"
  when "wrapper"
    @api_version = @existing_versions.first
    @wrapper_expr = @existing_versions.map{ |ver| "#{ver}:0.0" }.join ";"
    @extra_proto_files.delete '"google/cloud/common_resources.proto"'
  else
    error "Unknown generation type"
  end
end

def create_optional_sections
  @extra_proto_files_section = @proto_path_section = @service_override_section = ""
  unless @extra_proto_files.empty?
    lines = ["\n    extra_proto_files=["]
    @extra_proto_files.each { |entry| lines << "\n        #{entry}," }
    lines << "\n    ],"
    @extra_proto_files_section = lines.join
    logger.info "Creating optional section for extra_proto_files"
  end
  if @proto_path_base
    @proto_path_section = "\n    proto_path=\"#{@proto_path_base}/#{@api_version}\","
    logger.info "Creating optional section for proto_path"
  end
  if @service_override
    @service_override_section = "\n        \"ruby-cloud-service-override\": \"#{@service_override}\","
    logger.info "Creating optional section for ruby-cloud-service-override"
  end
end

def start_branch
  output = capture(["git", "status", "-s"]).strip
  error "Git checkout is not clean" unless output.empty?
  @orig_branch_name = capture(["git", "branch", "--show-current"]).strip
  exec ["git", "checkout", "-b", @branch_name]
end

def populate_initial_synth_script
  b = binding
  synth_path = "#{@gem_name}/synth.py"
  logger.info "Generating initial synth script #{synth_path} ..."
  FileUtils.mkdir_p @gem_name
  template_path = find_data "synth-#{@gen_type}-template.erb"
  template = File.read template_path
  erb = ERB.new template
  script = erb.result b
  File.open synth_path, "w" do |f|
    f.write script
  end
end

def edit_synth_script
  error "No EDITOR set" unless editor
  synth_path = "#{@gem_name}/synth.py"
  exec [editor, synth_path]
  new_content = File.read synth_path
  error "Aborted" if new_content.to_s.strip.empty?
end

def generate_lib
  Dir.chdir @gem_name do
    exec ["python", "-m", "synthtool"]
  end
end

def test_lib
  Dir.chdir @gem_name do
    exec ["bundle", "install"]
    exec ["bundle", "exec", "rake", "ci"]
  end
end

def update_configs
  exec ["bundle", "update"]
  exec ["bundle", "exec", "rake", "kokoro:build"]
end

def finish_branch
  unless confirm "Push PR for new #{@gen_type} client #{@gem_name.inspect}? ", :bold, default: true
    error "Aborted"
  end
  exec ["git", "add", ".kokoro", @gem_name]
  exec ["git", "commit", "-m", "feat: Initial generation of #{@gem_name}"]
  exec ["git", "push", "-u", git_remote, @branch_name]
  exec ["gh", "pr", "create",
        "--title", "feat: Initial generation of #{@gem_name}",
        "--body", "Auto-created at #{Time.now} using `toys gen-client`.",
        "--repo", "googleapis/google-cloud-ruby"]
  exec ["git", "checkout", @orig_branch_name]
end

def error *messages
  messages.each do |message|
    puts message, :red, :bold
  end
  exit 1
end
