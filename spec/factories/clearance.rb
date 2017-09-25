FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    email
    password 'password'
    first_name 'Bid'
    last_name 'Ule'
    street_number 1
    street 'rue machin'
    zip '75014'
    city 'Paris'
  end
end
