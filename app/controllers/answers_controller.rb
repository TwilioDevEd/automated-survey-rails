class AnswersController < ApplicationController
  def create
    # XXX: Think on some business object which encapsulates this interaction
    # like a coordinator.
    Answer.create(answer_params)
    next_question    = FindNextQuestion.for(params[:question_id])
    render xml: CreateResponse.for(next_question)
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
