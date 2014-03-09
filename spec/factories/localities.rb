# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :locality do
    name "Brooklyn"
    locality_id SecureRandom.uuid
  end
end
