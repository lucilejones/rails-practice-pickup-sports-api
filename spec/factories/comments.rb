FactoryBot.define do
  factory :comment do
      user
      content { Faker::Lorem.paragraph }
  end
end
