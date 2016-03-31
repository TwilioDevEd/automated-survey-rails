class SurveysController < ApplicationController
  def voice
    survey = Survey.first
    render xml: welcome_message_for_voice(survey)
  end

  def sms
    survey = Survey.first
    render xml: welcome_message_for_sms(survey)
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

  def welcome_message_for_sms(survey)
    Twilio::TwiML::Response.new do |r|
      r.Message do |msg|
        msg.Body "Thank you for taking the #{survey.title} survey"
      end
    end.to_xml
  end
end
