class QuestionsController < ApplicationController
  def show
    question = Question.find(params[:id])
    render xml: Voice::CreateResponse.for(question)
  end
end
