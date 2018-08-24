FactoryBot.define do
  factory :user do
    provider 'github'
    uid '5678'
    name 'pearl'
    token ENV['TEST_TOKEN']
    login 'brickstar'
  end
end
