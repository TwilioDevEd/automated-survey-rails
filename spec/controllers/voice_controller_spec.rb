require 'rails_helper'

describe VoiceController do
  describe '#connect' do
    before do
      question = double(:question, id: 1)
      survey = double(:survey, title: 'bees',
                               first_question: question)
      allow(Survey).to receive(:first) { survey }
      post :connect
    end

    it 'responds with `Say`' do
      document = Nokogiri::XML(response.body)
      expect(document.at_xpath('//Response//Say').content)
        .to eq('Thank you for taking the bees survey')
    end

    it 'responds with a `Redirect` to the first question' do
      document = Nokogiri::XML(response.body)
      expect(document.at_xpath('//Response//Redirect').content)
        .to eq(question_path(1))
    end

    it 'responds with ok' do
      expect(response).to be_ok
    end
  end
end
