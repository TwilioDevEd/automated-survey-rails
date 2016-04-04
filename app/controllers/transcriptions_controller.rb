class TranscriptionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    text = params[:TranscriptionText]
    Transcription.create(answer_id: answer_for_transcription.id, text: text)
    render nothing: true
  end

  private

  def answer_for_transcription
    question_id = params[:question_id]
    call_sid    = params[:CallSid]
    Answer.where(question_id: question_id, call_sid: call_sid).first
  end
end
