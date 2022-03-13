FactoryBot.define do
  factory :task, class: Task do

    title {Faker::Lorem.characters(number: 4)}
    description {Faker::Lorem.characters(number: 280)}

  end
end
