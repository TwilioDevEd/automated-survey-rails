require 'rails_helper'

describe QuestionsController do
  describe '#show' do
    let(:survey)   { Survey.create(title: 'survey') }
    let(:question) { Question.create(survey: survey, body: 'question') }

    before { get :show, id: question.id }

    it 'responds with the question' do
      expect(response.body).to include('question')
    end

    it 'responds with ok' do
      expect(response).to be_ok
    end
  end
end
