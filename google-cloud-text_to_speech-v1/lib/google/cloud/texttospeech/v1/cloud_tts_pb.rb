# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: google/cloud/texttospeech/v1/cloud_tts.proto

require 'google/protobuf'

require 'google/api/annotations_pb'
require 'google/api/client_pb'
require 'google/api/field_behavior_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("google/cloud/texttospeech/v1/cloud_tts.proto", :syntax => :proto3) do
    add_message "google.cloud.texttospeech.v1.ListVoicesRequest" do
      optional :language_code, :string, 1
    end
    add_message "google.cloud.texttospeech.v1.ListVoicesResponse" do
      repeated :voices, :message, 1, "google.cloud.texttospeech.v1.Voice"
    end
    add_message "google.cloud.texttospeech.v1.Voice" do
      repeated :language_codes, :string, 1
      optional :name, :string, 2
      optional :ssml_gender, :enum, 3, "google.cloud.texttospeech.v1.SsmlVoiceGender"
      optional :natural_sample_rate_hertz, :int32, 4
    end
    add_message "google.cloud.texttospeech.v1.SynthesizeSpeechRequest" do
      optional :input, :message, 1, "google.cloud.texttospeech.v1.SynthesisInput"
      optional :voice, :message, 2, "google.cloud.texttospeech.v1.VoiceSelectionParams"
      optional :audio_config, :message, 3, "google.cloud.texttospeech.v1.AudioConfig"
    end
    add_message "google.cloud.texttospeech.v1.SynthesisInput" do
      oneof :input_source do
        optional :text, :string, 1
        optional :ssml, :string, 2
      end
    end
    add_message "google.cloud.texttospeech.v1.VoiceSelectionParams" do
      optional :language_code, :string, 1
      optional :name, :string, 2
      optional :ssml_gender, :enum, 3, "google.cloud.texttospeech.v1.SsmlVoiceGender"
    end
    add_message "google.cloud.texttospeech.v1.AudioConfig" do
      optional :audio_encoding, :enum, 1, "google.cloud.texttospeech.v1.AudioEncoding"
      optional :speaking_rate, :double, 2
      optional :pitch, :double, 3
      optional :volume_gain_db, :double, 4
      optional :sample_rate_hertz, :int32, 5
      repeated :effects_profile_id, :string, 6
    end
    add_message "google.cloud.texttospeech.v1.SynthesizeSpeechResponse" do
      optional :audio_content, :bytes, 1
    end
    add_enum "google.cloud.texttospeech.v1.SsmlVoiceGender" do
      value :SSML_VOICE_GENDER_UNSPECIFIED, 0
      value :MALE, 1
      value :FEMALE, 2
      value :NEUTRAL, 3
    end
    add_enum "google.cloud.texttospeech.v1.AudioEncoding" do
      value :AUDIO_ENCODING_UNSPECIFIED, 0
      value :LINEAR16, 1
      value :MP3, 2
      value :OGG_OPUS, 3
    end
  end
end

module Google
  module Cloud
    module TextToSpeech
      module V1
        ListVoicesRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.texttospeech.v1.ListVoicesRequest").msgclass
        ListVoicesResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.texttospeech.v1.ListVoicesResponse").msgclass
        Voice = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.texttospeech.v1.Voice").msgclass
        SynthesizeSpeechRequest = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.texttospeech.v1.SynthesizeSpeechRequest").msgclass
        SynthesisInput = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.texttospeech.v1.SynthesisInput").msgclass
        VoiceSelectionParams = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.texttospeech.v1.VoiceSelectionParams").msgclass
        AudioConfig = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.texttospeech.v1.AudioConfig").msgclass
        SynthesizeSpeechResponse = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.texttospeech.v1.SynthesizeSpeechResponse").msgclass
        SsmlVoiceGender = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.texttospeech.v1.SsmlVoiceGender").enummodule
        AudioEncoding = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("google.cloud.texttospeech.v1.AudioEncoding").enummodule
      end
    end
  end
end
