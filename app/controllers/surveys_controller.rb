class SurveysController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @survey = Survey.includes(:questions).first
  end

  def voice
    survey = Survey.first
    render xml: welcome_message_for_voice(survey)
  end

  def sms
    user_response = params[:Body]
    from          = params[:From]
    render xml: SMS::ReplyProcessor.process(user_response, from, cookies)
  end

  private

  def welcome_message_for_voice(survey)
    Twilio::TwiML::Response.new do |r|
      r.Say "Thank you for taking the #{survey.title} survey"
      r.Redirect question_path(survey.first_question.id), method: 'GET'
    end.to_xml
  end
end
