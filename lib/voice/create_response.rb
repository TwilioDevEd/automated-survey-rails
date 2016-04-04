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

      Twilio::TwiML::Response.new do |r|
        r.Say question.body
        r.Say INSTRUCTIONS.fetch(question.type)
        if question.free?
          r.Record action: answers_path(question.id),
                   transcribe: true,
                   transcribeCallback: transcriptions_path(question.id)
        else
          r.Gather action: answers_path(question.id)
        end
      end.to_xml
    end

    private

    attr_reader :question

    def exit_message
      Twilio::TwiML::Response.new do |r|
        r.Say 'Thanks for your time. Good bye'
        r.Hangup
      end.to_xml
    end

    def answers_path(question_id)
      "/answers?question_id=#{question_id}"
    end

    def transcriptions_path(question_id)
      "/transcriptions?question_id=#{question_id}"
    end
  end
end
