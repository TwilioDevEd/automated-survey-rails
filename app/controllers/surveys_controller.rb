class SurveysController < ApplicationController
  def voice
    survey = Survey.first
    welcome_message = Twilio::TwiML::Response.new do |r|
                        r.Say "Thank you for taking the #{survey.title} survey"
                        r.Redirect question_path(survey.first_question.id)
                      end.to_xml

    render xml: welcome_message
  end
end
