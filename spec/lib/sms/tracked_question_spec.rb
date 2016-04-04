# require_relative '../../../lib/sms/tracked_question'
require 'rails_helper'

describe SMS::TrackedQuestion do
  subject(:tracked_question) { described_class.new(cookies) }

  let!(:question)            { build_stubbed(:question) }
  let!(:serialized_question) { question.serializable_hash.to_yaml }

  describe '#store_or_destroy' do
    let(:cookies) { {} }

    it 'stores the question' do
      tracked_question.store_or_destroy(question)
      expect(cookies[:question]).to eq(serialized_question)
    end

    context 'when the given question is Question::NoQuestion' do
      let(:cookies) { { question: serialized_question } }

      it 'destroys the question' do
        subject.store_or_destroy(Question::NoQuestion)
        expect(cookies[:question]).to be_nil
      end
    end
  end

  describe '#fetch' do
    context 'when there are a tracked question' do
      let(:cookies) { { question: serialized_question } }

      it 'returns the question' do
        expect(tracked_question.fetch).to eq(question)
      end
    end
  end

  describe '#destroy' do
    let(:cookies) { { question: serialized_question } }

    it 'destroys the question' do
      subject.destroy
      expect(cookies[:question]).to be_nil
    end
  end

  describe '#empty?' do
    context 'when there is no tracked question' do
      let(:cookies) { { question: '' } }

      it 'returns true' do
        expect(tracked_question.empty?).to be_truthy
      end
    end

    context 'when there is a tracked question' do
      let(:cookies) { { question: serialized_question } }

      it 'returns false' do
        expect(tracked_question.empty?).to be_falsey
      end
    end
  end

  describe '#present?' do
    context 'when there is a tracked question' do
      let(:cookies) { { question: serialized_question } }

      it 'returns true' do
        expect(tracked_question.present?).to be_truthy
      end
    end
  end
end
