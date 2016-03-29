require 'rails_helper'

describe VoiceController do
  describe '#connect' do
    before do
      allow(Survey).to receive(:first) { double(:survey, title: 'bees') }
      post :connect
    end

    it 'responds with a welcome message' do
      document = Nokogiri::XML(response.body)
      expect(document.at_xpath('//Response//Say').content)
        .to eq('Thank you for taking the bees survey')
    end

    it 'responds with ok' do
      expect(response).to be_ok
    end
  end
end
