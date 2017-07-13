module Voice
  class CreateResponse
    INSTRUCTIONS = {
      'free'    => 'Please record your answer after the beep and then hit the pound sign',
      'numeric' => 'Please press a number between 0 and 9 and then hit the pound sign',
      'yes_no'  => 'Please press the 1 for yes and the 0 for no and then hit the pound sign'
    }.freeze

    def self.for(question)
      new(question).response
    end

    def initialize(question)
      @question = question
    end

    def response
      return exit_message if question == Question::NoQuestion

      response = Twilio::TwiML::VoiceResponse.new
      response.say question.body
      response.say INSTRUCTIONS.fetch(question.type)
      if question.free?
        response.record action: answers_path(question.id),
                        transcribe: true,
                        transcribe_callback: transcriptions_path(question.id)
      else
        response.gather action: answers_path(question.id)
      end

      response.to_s
    end

    private

    attr_reader :question

    def exit_message
      response = Twilio::TwiML::VoiceResponse.new
      response.say 'Thanks for your time. Good bye'
      response.hangup
      response.to_s
    end

    def answers_path(question_id)
      "/answers?question_id=#{question_id}"
    end

    def transcriptions_path(question_id)
      "/transcriptions?question_id=#{question_id}"
    end
  end
end
