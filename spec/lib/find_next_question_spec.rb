require 'rails_helper'

describe FindNextQuestion do
  describe '.for' do
    let(:survey)          { create(:survey) }
    let!(:first_question) { create(:question, survey: survey, body: 'first') }
    let!(:last_question)  { create(:question, survey: survey, body: 'last') }

    context 'when there are available questions' do
      it 'responds with the next available question' do
        next_question = described_class.for(first_question)
        expect(next_question.body).to eq('last')
      end
    end

    context 'when there are no more questions' do
      it 'responds with Question::NoQuestion' do
        next_question = described_class.for(last_question)
        expect(next_question).to eq(Question::NoQuestion)
      end
    end
  end
end
