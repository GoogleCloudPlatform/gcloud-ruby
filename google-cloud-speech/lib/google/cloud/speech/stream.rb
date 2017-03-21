# Copyright 2016 Google Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


require "google/cloud/speech/v1beta1"
require "google/cloud/speech/result"
require "monitor"
require "forwardable"

module Google
  module Cloud
    module Speech
      ##
      # # Stream
      #
      # A resource that represents the streaming requests and responses.
      #
      # @example
      #   require "google/cloud/speech"
      #
      #   speech = Google::Cloud::Speech.new
      #
      #   stream = speech.stream encoding: :raw, sample_rate: 16000
      #
      #   # register callback for when a result is returned
      #   stream.on_result do |results|
      #     result = results.first
      #     puts result.transcript # "how old is the Brooklyn Bridge"
      #     puts result.confidence # 0.9826789498329163
      #   end
      #
      #   # Stream 5 seconds of audio from the microphone
      #   # Actual implementation of microphone input varies by platform
      #   5.times do
      #     stream.send MicrophoneInput.read(32000)
      #   end
      #
      #   # This sample assumes that it is part of a longer running process
      #   # that will run until the stream is complete.
      #   stream.stop
      #
      class Stream
        include MonitorMixin
        ##
        # @private Creates a new Speech Stream instance.
        # This must always be private, since it may change as the implementation
        # changes over time.
        def initialize service, streaming_recognize_request
          @service = service
          @streaming_recognize_request = streaming_recognize_request
          @results = []
          @callbacks = Hash.new { |h, k| h[k] = [] }
          super() # to init MonitorMixin
        end

        ##
        # Starts the stream. The stream will be started in the first #send call.
        def start
          return if @request_queue
          @request_queue = EnumeratorQueue.new(self)
          @request_queue.push @streaming_recognize_request

          Thread.new { background_run }
        end

        ##
        # Checks if the stream has been started.
        #
        # @return [boolean] `true` when started, `false` otherwise.
        def started?
          synchronize do
            !(!@request_queue)
          end
        end

        ##
        # Sends audio content to the server.
        #
        # @param [String] bytes A string of binary audio data to be recognized.
        #   The data should be encoded as `ASCII-8BIT`.
        #
        # @example
        #   require "google/cloud/speech"
        #
        #   speech = Google::Cloud::Speech.new
        #
        #   audio = speech.audio "path/to/audio.raw"
        #
        #   stream = speech.stream encoding: :raw, sample_rate: 16000
        #
        #   # register callback for when a result is returned
        #   stream.on_result do |results|
        #     result = results.first
        #     puts result.transcript # "how old is the Brooklyn Bridge"
        #     puts result.confidence # 0.9826789498329163
        #   end
        #
        #   # Stream 5 seconds of audio from the microphone
        #   # Actual implementation of microphone input varies by platform
        #   5.times do
        #     stream.send MicrophoneInput.read(32000)
        #   end
        #
        #   # This sample assumes that it is part of a longer running
        #   # process that will run until the stream is complete.
        #   stream.stop
        #
        def send bytes
          start # lazily call start if the stream wasn't started yet
          # TODO: do not send if stopped?
          synchronize do
            req = V1beta1::StreamingRecognizeRequest.new(
              audio_content: bytes.encode("ASCII-8BIT"))
            @request_queue.push req
          end
        end

        ##
        # Stops the stream. Signals to the server that no more data will be
        # sent.
        def stop
          synchronize do
            return if @request_queue.nil?
            @request_queue.push self
            @stopped = true
          end
        end

        ##
        # Checks if the stream has been stopped.
        #
        # @return [boolean] `true` when stopped, `false` otherwise.
        def stopped?
          synchronize do
            @stopped
          end
        end

        ##
        # The speech recognition results for the audio.
        #
        # @return [Array<Result>] The transcribed text of audio recognized.
        #
        # @example
        #   require "google/cloud/speech"
        #
        #   speech = Google::Cloud::Speech.new
        #
        #   stream = speech.stream encoding: :raw, sample_rate: 16000
        #
        #   # Stream 5 seconds of audio from the microphone
        #   # Actual implementation of microphone input varies by platform
        #   5.times do
        #     stream.send MicrophoneInput.read(32000)
        #   end
        #
        #   stream.stop
        #
        #   results = stream.results
        #   results.each do |result|
        #     puts result.transcript
        #     puts result.confidence
        #   end
        #
        def results
          synchronize do
            @results
          end
        end

        ##
        # Register to be notified on the reception of an interim result.
        #
        # @yield [callback] The block for accessing final and interim results.
        # @yieldparam [Array<Result>] final_results The final results.
        # @yieldparam [Array<Result>] interim_results The interim results.
        #
        # @example
        #   require "google/cloud/speech"
        #
        #   speech = Google::Cloud::Speech.new
        #
        #   stream = speech.stream encoding: :raw, sample_rate: 16000
        #
        #   # register callback for when an interim result is returned
        #   stream.on_interim do |final_results, interim_results|
        #     interim_result = interim_results.first
        #     puts interim_result.transcript # "how old is the Brooklyn Bridge"
        #     puts interim_result.confidence # 0.9826789498329163
        #     puts interim_result.stability # 0.8999
        #   end
        #
        #   # Stream 5 seconds of audio from the microphone
        #   # Actual implementation of microphone input varies by platform
        #   5.times do
        #     stream.send MicrophoneInput.read(32000)
        #   end
        #
        #   # This sample assumes that it is part of a longer running
        #   # process that will run until the stream is complete.
        #   stream.stop
        #
        def on_interim &block
          synchronize do
            @callbacks[:interim] << block
          end
        end

        # @private yields two arguments, all final results and the
        # non-final/incomplete result
        def interim! interim_results
          synchronize do
            @callbacks[:interim].each { |c| c.call results, interim_results }
          end
        end

        ##
        # Register to be notified on the reception of a final result.
        #
        # @yield [callback] The block for accessing final results.
        # @yieldparam [Array<Result>] results The final results.
        #
        # @example
        #   require "google/cloud/speech"
        #
        #   speech = Google::Cloud::Speech.new
        #
        #   stream = speech.stream encoding: :raw, sample_rate: 16000
        #
        #   # register callback for when an interim result is returned
        #   stream.on_result do |results|
        #     result = results.first
        #     puts result.transcript # "how old is the Brooklyn Bridge"
        #     puts result.confidence # 0.9826789498329163
        #   end
        #
        #   # Stream 5 seconds of audio from the microphone
        #   # Actual implementation of microphone input varies by platform
        #   5.times do
        #     stream.send MicrophoneInput.read(32000)
        #   end
        #
        #   # This sample assumes that it is part of a longer running
        #   # process that will run until the stream is complete.
        #   stream.stop
        #
        def on_result &block
          synchronize do
            @callbacks[:result] << block
          end
        end

        # @private add a result object, and call the callbacks
        def add_result!result_index, result_grpc
          synchronize do
            @results[result_index] = Result.from_grpc result_grpc
          end
          # callback for final result received
          result!
        end

        # @private yields each final results as they are received
        def result!
          synchronize do
            @callbacks[:result].each { |c| c.call results }
          end
        end

        ##
        # Register to be notified when speech has been detected in the audio
        # stream.
        #
        # @yield [callback] The block to be called when speech has been detected
        #   in the audio stream.
        #
        # @example
        #   require "google/cloud/speech"
        #
        #   speech = Google::Cloud::Speech.new
        #
        #   stream = speech.stream encoding: :raw, sample_rate: 16000
        #
        #   # register callback for when speech has started.
        #   stream.on_speech_start do
        #     puts "Speech has started."
        #   end
        #
        #   # Stream 5 seconds of audio from the microphone
        #   # Actual implementation of microphone input varies by platform
        #   5.times do
        #     stream.send MicrophoneInput.read(32000)
        #   end
        #
        #   # This sample assumes that it is part of a longer running
        #   # process that will run until the stream is complete.
        #   stream.stop
        #
        def on_speech_start &block
          synchronize do
            @callbacks[:speech_start] << block
          end
        end

        # @private returns single final result once :END_OF_UTTERANCE is
        # received.
        def speech_start!
          synchronize do
            @callbacks[:speech_start].each(&:call)
          end
        end

        ##
        # Register to be notified when speech has ceased to be detected in the
        # audio stream.
        #
        # @yield [callback] The block to be called when speech has ceased to be
        #   detected in the audio stream.
        #
        # @example
        #   require "google/cloud/speech"
        #
        #   speech = Google::Cloud::Speech.new
        #
        #   stream = speech.stream encoding: :raw, sample_rate: 16000
        #
        #   # register callback for when speech has ended.
        #   stream.on_speech_end do
        #     puts "Speech has ended."
        #   end
        #
        #   # Stream 5 seconds of audio from the microphone
        #   # Actual implementation of microphone input varies by platform
        #   5.times do
        #     stream.send MicrophoneInput.read(32000)
        #   end
        #
        #   # This sample assumes that it is part of a longer running
        #   # process that will run until the stream is complete.
        #   stream.stop
        #
        def on_speech_end &block
          synchronize do
            @callbacks[:speech_end] << block
          end
        end

        # @private yields single final result once :END_OF_UTTERANCE is
        # received.
        def speech_end!
          synchronize do
            @callbacks[:speech_end].each(&:call)
          end
        end

        ##
        # Register to be notified when the end of the audio stream has been
        # reached.
        #
        # @yield [callback] The block to be called when the end of the audio
        #   stream has been reached.
        #
        # @example
        #   require "google/cloud/speech"
        #
        #   speech = Google::Cloud::Speech.new
        #
        #   stream = speech.stream encoding: :raw, sample_rate: 16000
        #
        #   # register callback for when audio has ended.
        #   stream.on_complete do
        #     puts "Audio has ended."
        #   end
        #
        #   # Stream 5 seconds of audio from the microphone
        #   # Actual implementation of microphone input varies by platform
        #   5.times do
        #     stream.send MicrophoneInput.read(32000)
        #   end
        #
        #   # This sample assumes that it is part of a longer running
        #   # process that will run until the stream is complete.
        #   stream.stop
        #
        def on_complete &block
          synchronize do
            @callbacks[:complete] << block
          end
        end

        # @private yields all final results once the recognition is completed
        # depending on how the Stream is configured, this can be on the
        # reception of :END_OF_AUDIO or :END_OF_UTTERANCE.
        def complete!
          synchronize do
            @callbacks[:complete].each(&:call)
          end
        end

        ##
        # Register to be notified when the server has detected the end of the
        # user's speech utterance and expects no additional speech. Therefore,
        # the server will not process additional audio. The client should stop
        # sending additional audio data. This event only occurs when `utterance`
        # is `true`.
        #
        # @yield [callback] The block to be called when the end of the audio
        #   stream has been reached.
        #
        # @example
        #   require "google/cloud/speech"
        #
        #   speech = Google::Cloud::Speech.new
        #
        #   stream = speech.stream encoding: :raw,
        #                          sample_rate: 16000,
        #                          utterance: true
        #
        #   # register callback for when utterance has occurred.
        #   stream.on_utterance do
        #     puts "Utterance has occurred."
        #     stream.stop
        #   end
        #
        #   # Stream 5 seconds of audio from the microphone
        #   # Actual implementation of microphone input varies by platform
        #   5.times do
        #     stream.send MicrophoneInput.read(32000)
        #   end
        #
        #   # This sample assumes that it is part of a longer running
        #   # process that will run until the stream is complete.
        #   stream.stop unless stream.stopped?
        #
        def on_utterance &block
          synchronize do
            @callbacks[:utterance] << block
          end
        end

        # @private returns single final result once :END_OF_UTTERANCE is
        # received.
        def utterance!
          synchronize do
            @callbacks[:utterance].each(&:call)
          end
        end

        ##
        # Register to be notified of an error received during the stream.
        #
        # @yield [callback] The block for accessing final results.
        # @yieldparam [Exception] error The error raised.
        #
        # @example
        #   require "google/cloud/speech"
        #
        #   speech = Google::Cloud::Speech.new
        #
        #   stream = speech.stream encoding: :raw, sample_rate: 16000
        #
        #   # register callback for when an error is returned
        #   stream.on_error do |error|
        #     puts "The following error occurred while streaming: #{error}"
        #     stream.stop
        #   end
        #
        #   # Stream 5 seconds of audio from the microphone
        #   # Actual implementation of microphone input varies by platform
        #   5.times do
        #     stream.send MicrophoneInput.read(32000)
        #   end
        #
        #   # This sample assumes that it is part of a longer running
        #   # process that will run until the stream is complete.
        #   stream.stop
        #
        def on_error &block
          synchronize do
            @callbacks[:error] << block
          end
        end

        # @private returns error object from the stream thread.
        def error! err
          synchronize do
            @callbacks[:error].each { |c| c.call err }
          end
        end

        protected

        def background_run
          response_enum = @service.recognize_stream @request_queue.each_item
          response_enum.each do |response|
            begin
              background_results response
              background_endpointer response.endpointer_type
              background_error response.error
            rescue => e
              error! Google::Cloud::Error.from_error(e)
            end
          end
          Thread.pass
        end

        def background_results response
          # Handle the results (StreamingRecognitionResult)
          return unless response.results && response.results.any?

          final_grpc, interim_grpcs = *response.results
          if final_grpc && final_grpc.is_final
            add_result! response.result_index, final_grpc
          else
            # all results are interim
            interim_grpcs = response.results
          end

          # convert to Speech object from GRPC object
          interim_results = Array(interim_grpcs).map do |grpc|
            InterimResult.from_grpc grpc
          end
          # callback for interim results received
          interim! interim_results if interim_results.any?
        end

        def background_endpointer endpointer
          # Handle the endpointer by raising events
          if endpointer == :START_OF_SPEECH
            speech_start!
          elsif endpointer == :END_OF_SPEECH
            speech_end!
          elsif endpointer == :END_OF_AUDIO
            # TODO: do we automatically call stop here?
            complete!
          elsif endpointer == :END_OF_UTTERANCE
            # TODO: do we automatically call stop here?
            utterance!
          end
        end

        def background_error error
          return if error.nil?

          require "grpc/errors"
          fail GRPC::BadStatus.new(error.code, error.message)
        end

        # @private
        class EnumeratorQueue
          extend Forwardable
          def_delegators :@q, :push

          # @private
          def initialize sentinel
            @q = Queue.new
            @sentinel = sentinel
          end

          # @private
          def each_item
            return enum_for(:each_item) unless block_given?
            loop do
              r = @q.pop
              break if r.equal? @sentinel
              fail r if r.is_a? Exception
              yield r
            end
          end
        end
      end
    end
  end
end
