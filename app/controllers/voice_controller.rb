class VoiceController < ApplicationController
  def connect
    survey = Survey.first
    render xml: thanks_message(survey.title)
  end

  private

  def thanks_message(survey_title)
    Twilio::TwiML::Response.new do |r|
      r.Say "Thank you for taking the #{survey_title} survey"
    end.to_xml
  end
end
