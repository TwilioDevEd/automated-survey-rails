class AnswersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    Answer.create(answer_params)
    current_question = Question.find(params[:question_id])
    next_question    = FindNextQuestion.for(current_question)
    render xml: Voice::CreateResponse.for(next_question)
  end

  private

  def answer_params
    {
      from:        params[:From],
      content:     params[:RecordingUrl] || params[:Digits],
      question_id: params[:question_id],
      call_sid:    params[:CallSid]
    }
  end
end
