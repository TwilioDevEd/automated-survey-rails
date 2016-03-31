require 'rails_helper'

describe AnswersController do
  describe '#create' do
    let(:survey)   { create(:survey) }
    let(:question) { first_question }
    let!(:first_question) { create(:question, survey: survey, body: 'first') }
    let!(:last_question)  { create(:question, survey: survey, body: 'last') }

    it 'creates an answer' do
      expect do
        post :create, attributes_for_answer
      end.to change { Answer.count }.by(1)
    end

    context 'when there are more available questions' do
      let(:question) { first_question }

      it 'responds with the next question' do
        post :create, attributes_for_answer
        expect(response.body).to include('last')
      end
    end

    context 'when there are no more available questions' do
      let(:question) { last_question }

      it 'responds with the thanks message' do
        post :create, attributes_for_answer
        expect(response.body).to include('Thanks')
      end
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
