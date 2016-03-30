class Question < ActiveRecord::Base
  NoQuestion = Class.new

  # Use type column without STI
  self.inheritance_column = nil

  enum type: { free: 0, numeric: 1, yes_no: 2 }

  belongs_to :survey
  has_many :answers, dependent: :destroy
end
