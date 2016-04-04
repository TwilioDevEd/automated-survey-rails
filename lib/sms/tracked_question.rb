module SMS
  class TrackedQuestion
    def initialize(cookies)
      @cookies = cookies
    end

    def store_or_destroy(question)
      if question == Question::NoQuestion
        destroy
      else
        cookies[:question] = serialize(question)
      end
    end

    def fetch
      question = cookies.fetch(:question)
      deserialize(question)
    end

    def destroy
      cookies[:question] = nil
    end

    def empty?
      cookies[:question].nil? || cookies[:question].empty?
    end

    def present?
      !empty?
    end

    private

    attr_reader :cookies

    def serialize(question)
      question.serializable_hash.to_yaml
    end

    def deserialize(question)
      Question.new(YAML.load(question))
    end
  end
end
