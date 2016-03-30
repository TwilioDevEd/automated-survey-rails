class AnswersController < ApplicationController
  def create
    Answer.create(answer_params)
    render nothing: true
  end

  private

  def answer_params
    {
      from:        params[:From],
      content:     params[:RecordingUrl] || params[:Digits],
      question_id: params[:question_id]
    }
  end
end
