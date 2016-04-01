require_relative '../../../lib/sms/tracked_question'

describe SMS::TrackedQuestion do
  subject(:current_question) { described_class.new(cookies) }

  describe '#store' do
    let(:cookies) { {} }

    it 'stores the current question id' do
      current_question.store('1')
      expect(cookies[:question_id]).to eq('1')
    end
  end

  describe '#fetch' do
    context 'when there are a current question id' do
      let(:cookies) { { question_id: '1'} }

      it 'returns the current question id' do
        expect(current_question.fetch).to eq('1')
      end
    end

    context 'when there are no current question' do
      let(:cookies) { {} }

      it 'returns the SMS::CurrentQuestion::NoQuestion' do
        expect(current_question.fetch).to eq(SMS::TrackedQuestion::NoQuestion)
      end
    end
  end

  describe '#destroy' do
    let(:cookies) { { question_id: '1'} }

    it 'destroys the current question id' do
      subject.destroy
      expect(cookies[:question_id]).to be_nil
    end
  end

  describe '#empty?' do
    context 'when there are no current question' do
      let(:cookies) { {} }

      it 'returns false' do
        expect(current_question.empty?).to be_truthy
      end
    end

    context 'when there are a current question id' do
      let(:cookies) { { question_id: '1'} }

      it 'returns true' do
        expect(current_question.empty?).to be_falsey
      end
    end
  end

  describe '#present?' do
    context 'when there are a current question id' do
      let(:cookies) { { question_id: '1'} }

      it 'returns true' do
        expect(current_question.present?).to be_truthy
      end
    end
  end
end
