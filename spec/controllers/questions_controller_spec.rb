require 'rails_helper'

describe QuestionsController do
  describe '#show' do
    before do
      question = double(:question, body: 'do you like bears?')
      allow(Question).to receive(:find).with('1')  { question }
      get :show, id: '1'
    end

    it 'responds with a question' do
      document = Nokogiri::XML(response.body)
      expect(document.at_xpath('//Response//Say').content)
        .to eq('do you like bears?')
    end

    it 'responds with ok' do
      expect(response).to be_ok
    end
  end
end
