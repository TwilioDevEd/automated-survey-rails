require 'rails_helper'

describe AnswersController do
  describe '#create' do
    it 'responds with ok' do
      post :create
      expect(response).to be_ok
    end
  end
end
