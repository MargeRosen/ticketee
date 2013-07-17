FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "user#{n}@ticketee.com" }
    password "password"
    password_confirmation "password"
   # sub factory inherit all the attributes from its parent factory.
    factory :confirmed_user do
      after_create do |user|
        user.confirm!
      end
    end
   # Creates an special user - Admin
    factory :admin_user do
      after_create do |user|
        user.confirm!
        user.update_attribute(:admin, true)
      end
    end
  end
end
