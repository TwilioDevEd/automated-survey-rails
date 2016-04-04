module SMS
  class CreateResponse
    INSTRUCTIONS = {
      'free'    => 'Reply to this message with your answer',
      'numeric' => 'Reply with a number from "0" to "9" to this message',
      'yes_no'  => 'Reply with "1" for YES and "0" for NO to this message'
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
        r.Message do |msg|
          msg.Body message_body
        end
      end.to_xml
    end

    private

    attr_reader :question

    def exit_message
      Twilio::TwiML::Response.new do |r|
        r.Message do |msg|
          msg.Body 'Thanks for your time. Good bye'
        end
      end.to_xml
    end

    def message_body
      [question.body, INSTRUCTIONS.fetch(question.type)].join("\n\n")
    end
  end
end
