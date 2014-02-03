# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :member do
    email_address "MyString"
    first_name "MyString"
    last_name "MyString"
    address1 "MyString"
    address2 "MyString"
    city "MyString"
    state "MyString"
    zipcode "MyString"
    phone_number "MyString"
  end
end
