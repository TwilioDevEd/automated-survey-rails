require 'rails_helper'

describe AnswersController do
  let(:survey) { Survey.create(title: 'Bees') }
  let(:question) do
    Question.create(survey: survey, body: 'do you like bees?')
  end

  describe '#create' do
    subject { post :create, attributes_for_answer }

    it 'creates an answer' do
      expect do
        subject
      end.to change { Answer.count }.by(1)
    end

    it 'finds the next question'

    context 'when there are available questions' do
      it 'creates a response for the next question'
    end

    context 'when there are no more questions' do
      it 'creates a response for closing the survey'
    end

    it 'responds with ok' do
      expect(response).to be_ok
    end
  end

  private

  # XXX: Check the response from Twilio
  def attributes_for_answer
    {
      From:         '+14155559368',
      Digits:       '1',
      CallSid:      '12345',
      question_id:  question.id,
      RecordingUrl: 'http://example.com'
    }
  end
end
