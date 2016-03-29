class QuestionsController < ApplicationController
  def show
    question = Question.find(params[:id])
    render xml: CreateResponse.for(question)
  end
end
