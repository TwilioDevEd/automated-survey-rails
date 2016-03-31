require 'rails_helper'

describe SMS::CreateResponse do
  describe '.for' do
    subject { described_class.for(question) }

    let(:question_type) { 'free' }
    let(:question) do
      build_stubbed(:question, body: 'question?', type: question_type)
    end

    it 'creates a response with the question body' do
      expect(content_for('/Response/Message/Body'))
        .to include('question?')
    end

    context 'when the question type is "free"' do
      let(:question_type) { 'free' }

      it 'uses the instruction for free questions' do
        expect(content_for('/Response/Message/Body'))
          .to include('Reply to this message with your answer')
      end
    end

    context 'when the question type is "numeric"' do
      let(:question_type) { 'numeric' }

      it 'uses the instruction for numeric questions' do
        expect(content_for('/Response/Message/Body'))
          .to include('Reply with a number from "1" to "10" to this message')
      end
    end

    context 'when the question type is "yes_no"' do
      let(:question_type) { 'yes_no' }

      it 'uses the instruction for yes_no questions' do
        expect(content_for('/Response/Message/Body'))
          .to include('Reply with "1" for YES and "0" for NO to this message')
      end
    end

    context 'when the question is Question::NoQuestion' do
      let(:question) { Question::NoQuestion }

      it 'responds with a closing message' do
        expect(content_for('/Response/Message/Body'))
          .to eq('Thanks for your time. Good bye')
      end
    end
  end

  private

  def content_for(xpath)
    document = Nokogiri::XML(subject)
    document.at_xpath(xpath).content
  end
end
