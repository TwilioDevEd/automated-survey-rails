FactoryGirl.define do
  factory :question do
    survey
    sequence(:body) { |counter| "question #{counter}" }
  end
end
