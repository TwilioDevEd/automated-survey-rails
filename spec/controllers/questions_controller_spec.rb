require 'rails_helper'

describe QuestionsController do
  describe '#show' do
    let(:survey)   { create(:survey) }
    let(:question) { create(:question, survey: survey, body: 'question') }

    before { get :show, params: { id: question.id } }

    it 'responds with the question' do
      expect(response.body).to include('question')
    end

    it 'responds with ok' do
      expect(response).to be_ok
    end
  end
end
