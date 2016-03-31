require 'rails_helper'

describe SurveysController do
  describe '#voice' do
    let(:survey)    { create(:survey, title: 'bees') }
    let!(:question) { create(:question, survey: survey) }

    before do
      post :voice
    end

    it 'responds with a welcome message' do
      document = Nokogiri::XML(response.body)
      expect(document.at_xpath('/Response/Say').content)
        .to eq('Thank you for taking the bees survey')
    end

    it 'responds with a redirection to the first question' do
      document = Nokogiri::XML(response.body)
      expect(document.at_xpath('/Response/Redirect').content)
        .to eq(question_path(question.id))
    end

    it 'responds with ok' do
      expect(response).to be_ok
    end
  end
end
