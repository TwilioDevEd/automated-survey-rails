require 'rails_helper'

describe AnswersController do
  describe '#create' do
    it 'responds with 201' do
      post :create
      expect(response).to be_ok
    end
  end
end
