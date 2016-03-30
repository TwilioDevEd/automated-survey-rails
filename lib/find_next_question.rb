class FindNextQuestion
  def self.for(question)
    new(question).find_next
  end

  def initialize(question)
    @question = question
  end

  def find_next
    question_id = next_question_id
    if question_id
      Question.find(question_id)
    else
      Question::NoQuestion
    end
  end

  private

  attr_reader :question

  def questions_for_survey
    question.survey.questions.pluck(:id)
  end

  def next_question_id
    questions = questions_for_survey
    current_question_index = questions.index(question.id)
    questions[current_question_index.succ]
  end
end
