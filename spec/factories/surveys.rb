FactoryBot.define do
  factory :survey do
    sequence(:title) { |counter| "survey #{counter}" }
  end
end
