require 'rails_helper'

describe SurveysController do
  let(:survey)          { create(:survey, title: 'bees') }
  let!(:first_question) { create(:question, survey: survey) }

  describe '#voice' do
    before { post :voice }

    it 'responds with a welcome message' do
      document = Nokogiri::XML(response.body)
      expect(document.at_xpath('/Response/Say').content)
        .to eq('Thank you for taking the bees survey')
    end

    it 'responds with a redirection to the first question' do
      document = Nokogiri::XML(response.body)
      expect(document.at_xpath('/Response/Redirect').content)
        .to eq(question_path(first_question.id))
    end

    it 'responds with ok' do
      expect(response).to be_ok
    end
  end

  describe '#sms' do
    before { post :sms }

    it 'responds with a welcome message' do
      document = Nokogiri::XML(response.body)
      expect(document.at_xpath('/Response/Message/Body').content)
        .to eq('Thank you for taking the bees survey')
    end

    it 'responds with ok' do
      expect(response).to be_ok
    end
  end
end
