# Release History

### 0.11.1 / 2019-11-19

#### Documentation

* Update OutputAudioEncoding documentation

### 0.11.0 / 2019-11-12

#### Features

* Add new card types to the intent
  * Add Intent#browse_carousel_card to support a browse carousel
  * Add Intent#table_card to support a Table card for Actions on
  * Add Intent#media_content to support the media content card

### 0.10.0 / 2019-11-06

#### Features

* Add ListSelect#subtitle

#### Bug Fixes

* Update minimum runtime dependencies

#### Documentation

* Update Intent#priority documentation

### 0.9.0 / 2019-10-29

This release require Ruby 2.4 or later.

#### Documentation

* Clarify which Google Cloud Platform products support auto-discovered credentials

### 0.8.0 / 2019-10-15

#### Features

* WebhookResponse includes the session_entity_types field

#### Performance Improvements

* Update timeouts for detect_indent

### 0.7.0 / 2019-10-01

#### Features

* Support for fuzzy extraction
  * Add EntityType#enable_fuzzy_extraction
  * Add Kind::KIND_REGEXP
* Documentation updates

### 0.6.0 / 2019-08-23

#### Features

* Add InputAudioConfig#single_utterance

#### Documentation

* Update documentation

### 0.5.0 / 2019-07-08

* Add AgentsClient#set_agent and AgentsClient#delete_agent 
* Add Agent#api_version and Agent#tier
* Update documentation and product links
* Support overriding service host and port.

### 0.4.0 / 2019-06-12

* Add SpeechModelVariant
* Add InputAudioConfig#model_variant
* Add Intent::Message::Platform::GOOGLE_HANGOUTS
* Add VERSION constant

### 0.3.0 / 2019-04-29

* Client changes:
  * SessionsClient#detect_intent adds output_audio_config named argument
  * DetectIntentRequest adds #output_audio_config
  * DetectIntentResponse adds #output_audio and #output_audio_config
  * QueryParameters adds #sentiment_analysis_request_config
  * QueryResult adds #sentiment_analysis_result
* Resource changes
  * DetectIntentResponse#output_audio is added
  * OutputAudioConfig is added
  * Sentiment is added
  * SentimentAnalysisResult is added
  * SentimentAnalysisRequestConfig is added
* Generated documentation updates
* Add AUTHENTICATION.md guide.
* Update generated documentation.
* Update generated code examples.
* Extract gRPC header values from request.

### 0.2.3 / 2018-11-15

* Update network configuration.

### 0.2.2 / 2018-09-20

* Update documentation.
  * Change documentation URL to googleapis GitHub org.

### 0.2.1 / 2018-09-10

* Update documentation.

### 0.2.0 / 2018-08-21

* Move Credentials location:
  * Add Google::Cloud::Dialogflow::V2::Credentials
  * Remove Google::Cloud::Dialogflow::Credentials
* Update dependencies.
* Update documentation.

### 0.1.0 / 2018-04-16

* Initial release
