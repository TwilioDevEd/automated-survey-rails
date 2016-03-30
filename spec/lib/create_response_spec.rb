require 'nokogiri'
require_relative '../../lib/create_response'

describe CreateResponse do
  describe '.for' do
    let(:question_type) { 'free' }
    let(:free?)         { true }
    let(:question) do
      double(:question, id: 1,
             body:  'do you like bears?',
             free?: free?,
             type:  question_type)
    end

    subject { described_class.for(question) }

    it 'creates a response with the question body' do
      expect(content_for('/Response/Say[1]'))
      .to eq('do you like bears?')
    end

    context 'when the question type is "free"' do
      it 'uses an instruction for free questions' do
        expect(content_for('/Response/Say[2]'))
          .to eq('Please record your answer after the beep and then hit the pound sign')
      end

      it 'uses a record with an action to the given question' do
        expect(content_for('/Response/Record/@action'))
          .to eq('/answers?question_id=1')
      end
    end

    context 'when the question type is "numeric"' do
      let(:question_type) { 'numeric' }
      let(:free?)         { false }

      it 'uses an instruction for numeric questions' do
        expect(content_for('/Response/Say[2]'))
          .to eq('Please press a number between 0 and 9 and then hit the pound sign')
      end

      it 'uses a gather with an action to the given question' do
        expect(content_for('/Response/Gather/@action'))
          .to eq('/answers?question_id=1')
      end
    end

    context 'when the question type is "yes_no"' do
      let(:question_type) { 'yes_no' }
      let(:free?)         { false }

      it 'uses an instruction for yes_no questions' do
        expect(content_for('/Response/Say[2]'))
          .to eq('Please press the 1 for yes and the 0 for no and then hit the pound sign')
      end

      it 'uses a gather with an action to the given question' do
        expect(content_for('/Response/Gather/@action'))
          .to eq('/answers?question_id=1')
      end
    end
  end

  private

  def content_for(xpath)
    document = Nokogiri::XML(subject)
    document.at_xpath(xpath).content
  end
end
