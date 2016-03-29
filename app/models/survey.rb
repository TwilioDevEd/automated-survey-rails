class Survey < ActiveRecord::Base
  has_many :questions, dependent: :destroy

  def first_question
    questions.first
  end
end
