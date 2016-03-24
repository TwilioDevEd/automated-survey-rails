class Answer < ActiveRecord::Base
  enum source: { voice: 0, sms: 1 }

  belongs_to :question
end
