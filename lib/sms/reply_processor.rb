module SMS
  class ReplyProcessor
    def self.process(message, from, cookies)
      new(message, from, cookies).process
    end

    def initialize(message, from, cookies)
      @message = message
      @from    = from
      @tracked_question = TrackedQuestion.new(cookies)
    end

    def process
      return process_initial_response if initial_response?
      process_succ_response           if tracked_question.present?
    end

    private

    attr_reader :message, :from, :tracked_question

    def initial_response?
      tracked_question.empty?
    end

    def process_initial_response
      survey = Survey.first
      first_question = survey.first_question
      tracked_question.store_or_destroy(first_question)
      CreateResponse.for(first_question)
    end

    def process_succ_response
      previous_question = tracked_question.fetch
      Answer.create(attributes_for_answer(previous_question))
      next_question = FindNextQuestion.for(previous_question)
      tracked_question.store_or_destroy(next_question)
      CreateResponse.for(next_question)
    end

    def attributes_for_answer(question)
      {
        question_id: question.id,
        content: message,
        source: Answer.sources.fetch(:sms),
        from: from
      }
    end

    # Think about this case.
    def welcome_message_o
      survey = Survey.first
      Twilio::TwiML::Response.new do |r|
        r.Message do |msg|
          msg.Body "Thank you for taking the #{survey.title} survey"
        end
      end.to_xml
    end
  end
end
