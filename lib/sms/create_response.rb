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

      response = Twilio::TwiML::MessagingResponse.new
      message = Twilio::TwiML::Message.new
      body = Twilio::TwiML::Body.new(message_body)

      response.append(message)
      message.append(body)

      response.to_s
    end

    private

    attr_reader :question

    def exit_message
      response = Twilio::TwiML::MessagingResponse.new
      message = Twilio::TwiML::Message.new
      body = Twilio::TwiML::Body.new('Thanks for your time. Good bye')

      response.append(message)
      message.append(body)

      response.to_s
    end

    def message_body
      [question.body, INSTRUCTIONS.fetch(question.type)].join("\n\n")
    end
  end
end
