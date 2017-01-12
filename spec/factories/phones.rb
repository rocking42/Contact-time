# == Schema Information
#
# Table name: phones
#
#  id         :integer          not null, primary key
#  phone      :string
#  phone_type :string
#  contact_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :phone do
    phone { Faker::PhoneNumber.phone_number }
    association :contact #uses the contact factory

    factory :mobile_phone do
      phone_type "Mobile"
    end

    factory :office_phone do
      phone_type "Office"
    end

    factory :home_phone do
      phone_type "Home"
    end
    
  end
end
