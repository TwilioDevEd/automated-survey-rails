require 'rails_helper'

describe TranscriptionsController do
  let(:survey)    { create(:survey) }
  let(:question)  { create(:question, survey: survey) }
  let!(:answer)   { Answer.create(question: question,
                                  content: 'I like it',
                                  from: '+15555555',
                                  call_sid: '12345') }

  describe '#create' do
    it 'creates a transcription' do
      post :create, params: attributes_for_transcription
      expect(answer.transcription.text).to eq('transcription text')
    end
  end

  private

  def attributes_for_transcription
    {
      question_id:  question.id,
      CallSid: '12345',
      TranscriptionText: 'transcription text'
    }
  end
end
