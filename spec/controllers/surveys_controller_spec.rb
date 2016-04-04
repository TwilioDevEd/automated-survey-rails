require 'rails_helper'

describe SurveysController do
  let!(:survey) { create(:survey, title: 'bees') }

  describe '#index' do
    before { get :index }

    it 'responds with ok' do
      expect(response).to be_ok
    end

    it 'renders the :index template' do
      expect(response).to render_template(:index)
    end

    it 'assigns @survey' do
      expect(assigns(:survey)).to eq(survey)
    end
  end

  describe '#voice' do
    let!(:question) { create(:question, survey: survey) }

    before { post :voice }

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

  describe '#sms' do
    let!(:first_question) { create(:question, survey: survey, body: 'first') }
    let!(:last_question)  { create(:question, survey: survey, body: 'last') }

    context 'when the user replies to a question' do
      before do
        request.cookies[:question] = first_question.serializable_hash.to_yaml
        post :sms, Body: 'yes', From: 'from-phone-number'
      end

      it 'responds with the next question' do
        expect(content_for('/Response/Message/Body'))
          .to eq("last\n\nReply to this message with your answer")
      end
    end

    it 'responds with ok' do
      expect(response).to be_ok
    end
  end

  private

  def content_for(xpath)
    document = Nokogiri::XML(response.body)
    document.at_xpath(xpath).content
  end
end
