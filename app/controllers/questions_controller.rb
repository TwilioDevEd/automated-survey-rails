class QuestionsController < ApplicationController
  def show
    question = Question.find(params[:id])
    render xml: twiml_response(question.body)
  end

  def twiml_response(question)
    Twilio::TwiML::Response.new do |r|
      r.Say question
    end.to_xml
  end
end
