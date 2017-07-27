# Google Cloud Ruby Client

Idiomatic Ruby client for [Google Cloud Platform](https://cloud.google.com/) services.

[![CircleCI Build Status](https://circleci.com/gh/GoogleCloudPlatform/google-cloud-ruby.svg?&style=shield)](https://circleci.com/gh/GoogleCloudPlatform/google-cloud-ruby)
[![Travis-CI Build Status](https://travis-ci.org/GoogleCloudPlatform/google-cloud-ruby.svg)](https://travis-ci.org/GoogleCloudPlatform/google-cloud-ruby/)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/bc3w4im2g4ad0rah?svg=true)](https://ci.appveyor.com/project/GoogleCloudPlatform/google-cloud-ruby)
[![Coverage Status](https://img.shields.io/coveralls/GoogleCloudPlatform/google-cloud-ruby.svg)](https://coveralls.io/r/GoogleCloudPlatform/google-cloud-ruby?branch=master)
[![Gem Version](https://badge.fury.io/rb/gcloud.svg)](http://badge.fury.io/rb/gcloud)

* [Homepage](http://googlecloudplatform.github.io/google-cloud-ruby/)
* [API documentation](http://googlecloudplatform.github.io/google-cloud-ruby/#/docs)
* [google-cloud on RubyGems](https://rubygems.org/gems/google-cloud)

This client supports the following Google Cloud Platform services at a [General Availability (GA)](#versioning) quality level:

* [Cloud Datastore](#cloud-datastore-ga) (GA)
* [Stackdriver Logging](#stackdriver-logging-ga) (GA)
* [Cloud Storage](#cloud-storage-ga) (GA)
* [Cloud Translation API](#cloud-translation-api-ga) (GA)

This client supports the following Google Cloud Platform services at a [Beta](#versioning) quality level:

* [BigQuery](#bigquery-beta) (Beta)
* [Cloud Spanner API](#cloud-spanner-api-beta) (Beta)

This client supports the following Google Cloud Platform services at an [Alpha](#versioning) quality level:

* [Stackdriver Debugger](#stackdriver-debugger-alpha) (Alpha)
* [Cloud DNS](#cloud-dns-alpha) (Alpha)
* [Stackdriver Error Reporting](#stackdriv-error-reporting-alpha) (Alpha)
* [Cloud Natural Language API](#cloud-natural-language-api-alpha) (Alpha)
* [Cloud Pub/Sub](#cloud-pubsub-alpha) (Alpha)
* [Cloud Resource Manager](#cloud-resource-manager-alpha) (Alpha)
* [Stackdriver Trace](#stackdriver-trace-alpha) (Alpha)
* [Cloud Speech API](#cloud-speech-api-alpha) (Alpha)
* [Cloud Vision API](#cloud-vision-api-alpha) (Alpha)

The support for each service is distributed as a separate gem. However, for your convenience, the `google-cloud` gem lets you install the entire collection.

If you need support for other Google APIs, check out the [Google API Ruby Client library](https://github.com/google/google-api-ruby-client).

## Quick Start

```sh
$ gem install google-cloud
```

The `google-cloud` gem shown above provides all of the individual service gems in the google-cloud-ruby project, making it easy to explore Google Cloud Platform. To avoid unnecessary dependencies, you can also install the service gems independently.

### Authentication

In general, the google-cloud-ruby library uses [Service Account](https://cloud.google.com/iam/docs/creating-managing-service-accounts) credentials to connect to Google Cloud services. When running on Compute Engine the credentials will be discovered automatically. When running on other environments, the Service Account credentials can be specified by providing the path to the [JSON keyfile](https://cloud.google.com/iam/docs/managing-service-account-keys) for the account (or the JSON itself) in environment variables. Additionally, Cloud SDK credentials can also be discovered automatically, but this is only recommended during development.

General instructions, environment variables, and configuration options are covered in the general [Authentication guide](http://googlecloudplatform.github.io/google-cloud-ruby/#/docs/google-cloud/guides/authentication) for the `google-cloud` umbrella package. Specific instructions and environment variables for each individual service are linked from the README documents listed below for each service.

The preview examples below demonstrate how to provide the **Project ID** and **Credentials JSON file path** directly in code.

### BigQuery (Beta)

- [google-cloud-bigquery README](google-cloud-bigquery/README.md)
- [google-cloud-bigquery API documentation](http://googlecloudplatform.github.io/google-cloud-ruby/#/docs/google-cloud-bigquery/latest)
- [google-cloud-bigquery on RubyGems](https://rubygems.org/gems/google-cloud-bigquery)
- [Google BigQuery documentation](https://cloud.google.com/bigquery/docs)

#### Quick Start

```sh
$ gem install google-cloud-bigquery
```

#### Preview

```ruby
require "google/cloud/bigquery"

bigquery = Google::Cloud::Bigquery.new(
  project: "my-todo-project",
  keyfile: "/path/to/keyfile.json"
)

# Create a new table to archive todos
dataset = bigquery.dataset "my-todo-archive"
table = dataset.create_table "todos",
          name: "Todos Archive",
          description: "Archive for completed TODO records"

# Load data into the table
file = File.open "/archive/todos/completed-todos.csv"
load_job = table.load file

# Run a query for the number of completed todos by owner
count_sql = "SELECT owner, COUNT(*) AS complete_count FROM todos GROUP BY owner"
data = bigquery.query count_sql
data.each do |row|
  puts row[:name]
end
```

### Cloud Datastore (GA)

- [google-cloud-datastore README](google-cloud-datastore/README.md)
- [google-cloud-datastore API documentation](http://googlecloudplatform.github.io/google-cloud-ruby/#/docs/google-cloud-datastore/latest)
- [google-cloud-datastore on RubyGems](https://rubygems.org/gems/google-cloud-datastore)
- [Google Cloud Datastore documentation](https://cloud.google.com/datastore/docs)

*Follow the [activation instructions](https://cloud.google.com/datastore/docs/activate) to use the Google Cloud Datastore API with your project.*

#### Quick Start

```sh
$ gem install google-cloud-datastore
```

#### Preview

```ruby
require "google/cloud/datastore"

datastore = Google::Cloud::Datastore.new(
  project: "my-todo-project",
  keyfile: "/path/to/keyfile.json"
)

# Create a new task to demo datastore
task = datastore.entity "Task", "sampleTask" do |t|
  t["type"] = "Personal"
  t["done"] = false
  t["priority"] = 4
  t["description"] = "Learn Cloud Datastore"
end

# Save the new task
datastore.save task

# Run a query for all completed tasks
query = datastore.query("Task").
  where("done", "=", false)
tasks = datastore.run query
```

### Stackdriver Debugger (Alpha)

- [google-cloud-debugger README](google-cloud-debugger/README.md)
- [google-cloud-debugger instrumentation documentation](https://googlecloudplatform.github.io/google-cloud-ruby/#/docs/google-cloud-debugger/guides/instrumentation)
- [google-cloud-debugger on RubyGems](https://rubygems.org/gems/google-cloud-debugger)
- [Stackdriver Debugger documentation](https://cloud.google.com/debugger/docs)

#### Quick Start

```
$ gem install google-cloud-debugger
```

#### Preview

```ruby
require "google/cloud/debugger"

debugger = Google::Cloud::Debugger.new
debugger.start
```

### Cloud DNS (Alpha)

- [google-cloud-dns README](google-cloud-dns/README.md)
- [google-cloud-dns API documentation](http://googlecloudplatform.github.io/google-cloud-ruby/#/docs/google-cloud-dns/latest)
- [google-cloud-dns on RubyGems](https://rubygems.org/gems/google-cloud-dns)
- [Google Cloud DNS documentation](https://cloud.google.com/dns/docs)

#### Quick Start

```sh
$ gem install google-cloud-dns
```

#### Preview

```ruby
require "google/cloud/dns"

dns = Google::Cloud::Dns.new

# Retrieve a zone
zone = dns.zone "example-com"

# Update records in the zone
change = zone.update do |tx|
  tx.add     "www", "A",  86400, "1.2.3.4"
  tx.remove  "example.com.", "TXT"
  tx.replace "example.com.", "MX", 86400, ["10 mail1.example.com.",
                                           "20 mail2.example.com."]
  tx.modify "www.example.com.", "CNAME" do |r|
    r.ttl = 86400 # only change the TTL
  end
end

```

### Stackdriver Error Reporting (Alpha)

- [google-cloud-error_reporting README](google-cloud-error_reporting/README.md)
- [google-cloud-error_reporting instrumentation documentation](https://googlecloudplatform.github.io/google-cloud-ruby/#/docs/google-cloud-error_reporting/guides/instrumentation)
- [google-cloud-error_reporting on RubyGems](https://rubygems.org/gems/google-cloud-error_reporting)
- [Stackdriver Error Reporting documentation](https://cloud.google.com/error-reporting/docs)

#### Quick Start

```sh
$ gem install google-cloud-error_reporting
```

#### Preview

```ruby
require "google/cloud/error_reporting"

# Report an exception
begin
  fail "Boom!"
rescue => exception
  Google::Cloud::ErrorReporting.report exception
end
```

### Stackdriver Logging (GA)

- [google-cloud-logging README](google-cloud-logging/README.md)
- [google-cloud-logging API documentation](http://googlecloudplatform.github.io/google-cloud-ruby/#/docs/google-cloud-logging/latest)
- [google-cloud-logging on RubyGems](https://rubygems.org/gems/google-cloud-logging)
- [Stackdriver Logging documentation](https://cloud.google.com/logging/docs/)

#### Quick Start

```sh
$ gem install google-cloud-logging
```

#### Preview

```ruby
require "google/cloud/logging"

logging = Google::Cloud::Logging.new

# List all log entries
logging.entries.each do |e|
  puts "[#{e.timestamp}] #{e.log_name} #{e.payload.inspect}"
end

# List only entries from a single log
entries = logging.entries filter: "log:syslog"

# Write a log entry
entry = logging.entry
entry.payload = "Job started."
entry.log_name = "my_app_log"
entry.resource.type = "gae_app"
entry.resource.labels[:module_id] = "1"
entry.resource.labels[:version_id] = "20150925t173233"

logging.write_entries entry
```

### Cloud Natural Language API (Alpha)

- [google-cloud-language README](google-cloud-language/README.md)
- [google-cloud-language API documentation](http://googlecloudplatform.github.io/google-cloud-ruby/#/docs/google-cloud-language/latest)
- [google-cloud-language on RubyGems](https://rubygems.org/gems/[google-cloud-language)
- [Google Cloud Natural Language API documentation](https://cloud.google.com/natural-language/docs)

#### Quick Start

```sh
$ gem install google-cloud-language
```

#### Preview

```ruby
require "google/cloud/language"

language = Google::Cloud::Language.new

content = "Star Wars is a great movie. The Death Star is fearsome."
document = language.document content
annotation = document.annotate

annotation.entities.count #=> 3
annotation.sentiment.score #=> 0.10000000149011612
annotation.sentiment.magnitude #=> 1.100000023841858
annotation.sentences.count #=> 2
annotation.tokens.count #=> 13
```

### Cloud Pub/Sub (Alpha)

- [google-cloud-pubsub README](google-cloud-pubsub/README.md)
- [google-cloud-pubsub API documentation](http://googlecloudplatform.github.io/google-cloud-ruby/#/docs/google-cloud-pubsub/latest)
- [google-cloud-pubsub on RubyGems](https://rubygems.org/gems/[google-cloud-pubsub)
- [Google Cloud Pub/Sub documentation](https://cloud.google.com/pubsub/docs)

#### Quick Start

```sh
$ gem install google-cloud-pubsub
```

#### Preview

```ruby
require "google/cloud/pubsub"

pubsub = Google::Cloud::Pubsub.new(
  project: "my-todo-project",
  keyfile: "/path/to/keyfile.json"
)

# Retrieve a topic
topic = pubsub.topic "my-topic"

# Publish a new message
msg = topic.publish "new-message"

# Retrieve a subscription
sub = pubsub.subscription "my-topic-sub"

# Pull available messages
msgs = sub.pull
```

### Cloud Resource Manager (Alpha)

- [google-cloud-resource_manager README](google-cloud-resource_manager/README.md)
- [google-cloud-resource_manager API documentation](http://googlecloudplatform.github.io/google-cloud-ruby/#/docs/google-cloud-resource_manager/latest)
- [google-cloud-resource_manager on RubyGems](https://rubygems.org/gems/google-cloud-resource_manager)
- [Google Cloud Resource Manager documentation](https://cloud.google.com/resource-manager/)

#### Quick Start

```sh
$ gem install google-cloud-resource_manager
```

#### Preview

```ruby
require "google/cloud/resource_manager"

resource_manager = Google::Cloud::ResourceManager.new

# List all projects
resource_manager.projects.each do |project|
  puts projects.project_id
end

# Label a project as production
project = resource_manager.project "tokyo-rain-123"
project.update do |p|
  p.labels["env"] = "production"
end

# List only projects with the "production" label
projects = resource_manager.projects filter: "labels.env:production"
```

### Stackdriver Trace (Alpha)

- [google-cloud-trace README](google-cloud-trace/README.md)
- [google-cloud-trace instrumentation documentation](https://googlecloudplatform.github.io/google-cloud-ruby/#/docs/google-cloud-trace/guides/instrumentation)
- [google-cloud-trace on RubyGems](https://rubygems.org/gems/google-cloud-trace)
- [Stackdriver Trace documentation](https://cloud.google.com/trace/docs/)

#### Quick Start

```sh
$ gem install google-cloud-trace
```

#### Preview

```ruby
require "google/cloud/trace"

trace = Google::Cloud::Trace.new

result_set = trace.list_traces Time.now - 3600, Time.now
result_set.each do |trace_record|
  puts "Retrieved trace ID: #{trace_record.trace_id}"
end
```

### Cloud Spanner API (Beta)

- [google-cloud-spanner README](google-cloud-spanner/README.md)
- [google-cloud-spanner API documentation](http://googlecloudplatform.github.io/google-cloud-ruby/#/docs/google-cloud-spanner/latest)
- [google-cloud-spanner on RubyGems](https://rubygems.org/gems/google-cloud-spanner)
- [Google Cloud Speech API documentation](https://cloud.google.com/spanner/docs)

#### Quick Start

```sh
$ gem install google-cloud-spanner
```

#### Preview

```ruby
require "google/cloud/spanner"

spanner = Google::Cloud::Spanner.new

db = spanner.client "my-instance", "my-database"

db.transaction do |tx|
  results = tx.execute "SELECT * FROM users"

  results.rows.each do |row|
    puts "User #{row[:id]} is #{row[:name]}"
  end
end
```

### Cloud Speech API (Alpha)

- [google-cloud-speech README](google-cloud-speech/README.md)
- [google-cloud-speech API documentation](http://googlecloudplatform.github.io/google-cloud-ruby/#/docs/google-cloud-speech/latest)
- [google-cloud-speech on RubyGems](https://rubygems.org/gems/google-cloud-speech)
- [Google Cloud Speech API documentation](https://cloud.google.com/speech/docs)

#### Quick Start

```sh
$ gem install google-cloud-speech
```

#### Preview

```ruby
require "google/cloud/speech"

speech = Google::Cloud::Speech.new

audio = speech.audio "path/to/audio.raw",
                     encoding: :raw, sample_rate: 16000
results = audio.recognize

result = results.first
result.transcript #=> "how old is the Brooklyn Bridge"
result.confidence #=> 0.9826789498329163
```

### Cloud Storage (GA)

- [google-cloud-storage README](google-cloud-storage/README.md)
- [google-cloud-storage API documentation](http://googlecloudplatform.github.io/google-cloud-ruby/#/docs/google-cloud-storage/latest)
- [google-cloud-storage on RubyGems](https://rubygems.org/gems/google-cloud-storage)
- [Google Cloud Storage documentation](https://cloud.google.com/storage/docs)

#### Quick Start

```sh
$ gem install google-cloud-storage
```

#### Preview

```ruby
require "google/cloud/storage"

storage = Google::Cloud::Storage.new(
  project: "my-todo-project",
  keyfile: "/path/to/keyfile.json"
)

bucket = storage.bucket "task-attachments"

file = bucket.file "path/to/my-file.ext"

# Download the file to the local file system
file.download "/tasks/attachments/#{file.name}"

# Copy the file to a backup bucket
backup = storage.bucket "task-attachment-backups"
file.copy backup, file.name
```

### Cloud Translation API (GA)

- [google-cloud-translate README](google-cloud-translate/README.md)
- [google-cloud-translate API documentation](http://googlecloudplatform.github.io/google-cloud-ruby/#/docs/google-cloud-translate/latest)
- [google-cloud-translate on RubyGems](https://rubygems.org/gems/google-cloud-translate)
- [Google Cloud Translation API documentation](https://cloud.google.com/translation/docs)

#### Quick Start

```sh
$ gem install google-cloud-translate
```

#### Preview

```ruby
require "google/cloud/translate"

translate = Google::Cloud::Translate.new

translation = translate.translate "Hello world!", to: "la"

puts translation #=> Salve mundi!

translation.from #=> "en"
translation.origin #=> "Hello world!"
translation.to #=> "la"
translation.text #=> "Salve mundi!"
```

### Cloud Vision API (Alpha)

- [google-cloud-vision README](google-cloud-vision/README.md)
- [google-cloud-vision API documentation](http://googlecloudplatform.github.io/google-cloud-ruby/#/docs/google-cloud-vision/latest)
- [google-cloud-vision on RubyGems](https://rubygems.org/gems/google-cloud-vision)
- [Google Cloud Vision API documentation](https://cloud.google.com/vision/docs)

#### Quick Start

```sh
$ gem install google-cloud-vision
```

#### Preview

```ruby
require "google/cloud/vision"

vision = Google::Cloud::Vision.new

image = vision.image "path/to/landmark.jpg"

landmark = image.landmark
landmark.description #=> "Mount Rushmore"
```

## Supported Ruby Versions

google-cloud-ruby is supported on Ruby 2.0+.

## Versioning

This library follows [Semantic Versioning](http://semver.org/).

Please note it is currently under active development. Any release versioned 0.x.y is subject to backwards incompatible changes at any time.

**GA**: Libraries defined at the GA (general availability) quality level are stable. The code surface will not change in backwards-incompatible ways unless absolutely necessary (e.g. because of critical security issues) or with an extensive deprecation period. Issues and requests against GA libraries are addressed with the highest priority.

Please note that the auto-generated portions of the GA libraries (the ones in modules such as `v1` or `v2`) are considered to be of **Beta** quality, even if the libraries that wrap them are GA.

**Beta**: Libraries defined at a Beta quality level are expected to be mostly stable and we're working towards their release candidate. We will address issues and requests with a higher priority.

**Alpha**: Libraries defined at an Alpha quality level are still a work-in-progress and are more likely to get backwards-incompatible updates.

## Contributing

Contributions to this library are always welcome and highly encouraged.

See [CONTRIBUTING](CONTRIBUTING.md) for more information on how to get started.

Please note that this project is released with a Contributor Code of Conduct. By participating in this project you agree to abide by its terms. See [Code of Conduct](CODE_OF_CONDUCT.md) for more information.

## License

This library is licensed under Apache 2.0. Full license text is
available in [LICENSE](LICENSE).

## Support

Please [report bugs at the project on Github](https://github.com/GoogleCloudPlatform/google-cloud-ruby/issues).
Don't hesitate to [ask questions](http://stackoverflow.com/questions/tagged/google-cloud-platform+ruby) about the client or APIs on [StackOverflow](http://stackoverflow.com).
