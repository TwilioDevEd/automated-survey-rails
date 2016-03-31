class SurveysController < ApplicationController
  def voice
    survey = Survey.first
    render xml: welcome_message_for_voice(survey)
  end

  def sms
    render xml: SMS::ReplyProcessor.process(user_response, cookies)
  end

  private

  def user_response
    params[:Body]
  end

  def welcome_message_for_voice(survey)
    Twilio::TwiML::Response.new do |r|
      r.Say "Thank you for taking the #{survey.title} survey"
      r.Redirect question_path(survey.first_question.id)
    end.to_xml
  end
end
