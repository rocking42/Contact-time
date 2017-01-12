# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  first_name :string
#  last_name  :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :contact do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    sequence(:email) { |i| "johndoe#{i}@ga.co" }

    after(:build) do |contact|
      [:home_phone, :office_phone, :mobile_phone].each do |p|
        FactoryGirl.create p, contact: contact
      end
    end
  end
end
