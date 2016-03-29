class VoiceController < ApplicationController
  def connect
    survey = Survey.first
    render xml: twiml_response(survey)
  end

  private

  def twiml_response(survey)
    Twilio::TwiML::Response.new do |r|
      r.Say "Thank you for taking the #{survey.title} survey"
      r.Redirect question_path(survey.first_question.id)
    end.to_xml
  end
end
