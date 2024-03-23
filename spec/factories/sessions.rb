# spec/factories/sessions.rb
FactoryBot.define do
    factory :session do
      start { Time.now }
      duration { 60 }
    end
  end