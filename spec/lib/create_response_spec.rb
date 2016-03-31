require 'rails_helper'

describe CreateResponse do
  describe '.for' do
    subject { described_class.for(question) }

    let(:question_type) { 'free' }
    let(:question) do
      build_stubbed(:question, body: 'question?', type: question_type)
    end

    it 'creates a response with the question body' do
      expect(content_for('/Response/Say[1]'))
        .to eq('question?')
    end

    context 'when the question type is "free"' do
      it 'uses an instruction for free questions' do
        expect(content_for('/Response/Say[2]'))
          .to eq('Please record your answer after the beep and then hit the pound sign')
      end

      it 'uses a record with an action to the given question' do
        expect(content_for('/Response/Record/@action'))
          .to eq("/answers?question_id=#{question.id}")
      end
    end

    context 'when the question type is "numeric"' do
      let(:question_type) { 'numeric' }

      it 'uses an instruction for numeric questions' do
        expect(content_for('/Response/Say[2]'))
          .to eq('Please press a number between 0 and 9 and then hit the pound sign')
      end

      it 'uses a gather with an action to the given question' do
        expect(content_for('/Response/Gather/@action'))
          .to eq("/answers?question_id=#{question.id}")
      end
    end

    context 'when the question type is "yes_no"' do
      let(:question_type) { 'yes_no' }

      it 'uses an instruction for yes_no questions' do
        expect(content_for('/Response/Say[2]'))
          .to eq('Please press the 1 for yes and the 0 for no and then hit the pound sign')
      end

      it 'uses a gather with an action to the given question' do
        expect(content_for('/Response/Gather/@action'))
          .to eq("/answers?question_id=#{question.id}")
      end
    end

    context 'when the question is Question::NoQuestion' do
      let(:question) { Question::NoQuestion }

      it 'responds with a closing message' do
        expect(content_for('/Response/Say'))
          .to eq('Thanks for your time. Good bye')
      end

      it 'responds hanging up' do
        expect(content_for('/Response/Hangup')).to_not be_nil
      end
    end
  end

  private

  def content_for(xpath)
    document = Nokogiri::XML(subject)
    document.at_xpath(xpath).content
  end
end
