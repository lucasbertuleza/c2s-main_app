FactoryBot.define do
  factory :task do
    user { nil }
    url { "MyString" }
    uuid { "MyString" }
    status { 1 }
    data { "" }
  end
end
