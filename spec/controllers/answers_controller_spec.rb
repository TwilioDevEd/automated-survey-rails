require 'rails_helper'

describe AnswersController do
  let(:survey)   { Survey.create(title: 'Bees') }
  let(:question) { Question.create(survey: survey, body: 'question') }

  describe '#create' do
    let(:next_question) { double(:question) }

    before do |example|
      allow(FindNextQuestion).to receive(:for).with(question.id.to_s)
        .and_return(next_question)
      allow(CreateResponse).to receive(:for).with(next_question)
        .and_return('<response />')

      unless example.metadata[:skip_before]
        post :create, attributes_for_answer
      end
    end

    it 'creates an answer', skip_before: true do
      expect do
        post :create, attributes_for_answer
      end.to change { Answer.count }.by(1)
    end

    it 'finds the next question' do
      question_id = question.id.to_s
      expect(FindNextQuestion).to have_received(:for).with(question_id).once
    end

    it 'creates a response for the given question' do
      expect(CreateResponse).to have_received(:for).with(next_question).once
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
