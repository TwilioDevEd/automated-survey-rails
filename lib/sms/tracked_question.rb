module SMS
  class TrackedQuestion
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

    def empty?
      cookies[:question_id].nil?
    end

    def present?
      !empty?
    end

    private

    attr_reader :cookies
  end
end
