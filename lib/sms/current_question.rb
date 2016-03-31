module SMS
  class CurrentQuestion
    NoQuestion = Class.new

    def initialize(cookies)
      @cookies = cookies
    end

    def store(question_id)
      cookies[:question_id] = question_id
    end

    def fetch
      cookies.fetch(:question_id, NoQuestion)
    end

    def destroy
      cookies[:question_id] = nil
    end

    private

    attr_reader :cookies
  end
end
