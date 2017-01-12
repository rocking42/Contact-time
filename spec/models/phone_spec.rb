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

require 'rails_helper'

RSpec.describe Phone, type: :model do
  it "has a valid factory" do
    phone = build :home_phone
    expect(phone).to be_valid
  end

  it "is able to access it's associated contact" do
    contact = create :contact
    phone = create :home_phone, contact: contact
    expect(phone.contact).to be(contact)
  end
end
