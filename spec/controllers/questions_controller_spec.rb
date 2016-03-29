require 'rails_helper'

describe QuestionsController do
  describe '#show' do
    let(:question) { double(:question, body: 'do you like bears?') }

    before do
      allow(Question).to receive(:find).with('1') { question }
      allow(CreateResponse).to receive(:for).with(question) { '<response />' }
      get :show, id: '1'
    end

    it 'finds a given question' do
      expect(Question).to have_received(:find).with('1').once
    end

    it 'creates a response for the given question' do
      expect(CreateResponse).to have_received(:for).with(question).once
    end

    it 'responds with ok' do
      expect(response).to be_ok
    end
  end
end
