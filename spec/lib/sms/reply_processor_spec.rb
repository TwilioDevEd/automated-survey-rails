require 'rails_helper'

describe SMS::ReplyProcessor do
  describe '.process' do
    subject { described_class.process(message, cookies) }

    let(:survey) { create(:survey, title: 'bees') }

    let!(:first_question) { create(:question, survey: survey, body: 'first') }
    let!(:last_question)  { create(:question, survey: survey, body: 'last') }

    context 'when there are no tracked questions' do
      let(:message) { 'start' }
      let(:cookies) { {} }

      it 'responds with the first question' do
        expect(content_for('/Response/Message/Body'))
          .to eq("first\n\nReply to this message with your answer")
      end

      it 'track the current question' do
        subject
        expect(cookies[:question]).to include(first_question.id.to_s)
      end
    end

    context 'when there are a tracked question' do
      let(:message) { 'answer for the question' }
      let(:cookies) { { question: serialize_question(first_question) } }

      it 'creates an answer' do
        expect do
          subject
        end.to change { Answer.count }.by(1)
      end

      context 'when there are questions available' do
        it 'responds with the next available question' do
          expect(content_for('/Response/Message/Body'))
            .to eq("last\n\nReply to this message with your answer")
        end

        it 'track the current question' do
          subject
          expect(cookies[:question]).to include(last_question.id.to_s)
        end
      end

      context 'when there are no more questions available' do
        let(:cookies) { { question: serialize_question(last_question) } }

        it 'responds with the exit message' do
          expect(content_for('/Response/Message/Body'))
            .to eq('Thanks for your time. Good bye')
        end

        it 'untrack the current question' do
          subject
          expect(cookies[:question]).to be_nil
        end
      end
    end
  end

  private

  def content_for(xpath)
    document = Nokogiri::XML(subject)
    document.at_xpath(xpath).content
  end

  def serialize_question(question)
    question.serializable_hash.to_yaml
  end
end
