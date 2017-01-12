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

require 'rails_helper'

RSpec.describe Contact, type: :model do

  it "has a valid factory" do
    expect(build(:contact)).to be_valid
  end


  it "has three phone numbers" do
    contact = create :contact
    expect(contact.phones.length).to eq(3)
  end

  it "is valid with a first name, last name and email" do
    # Setup the data
    contact = build(:contact)
    # Validate something
    expect(contact).to be_valid
  end

  it "is invalid without a first name" do
    # Setup the data
    contact = build(:contact, first_name: nil)
    # Validate something
    contact.valid?
    expect(contact.errors[:first_name]).to include("can't be blank")
  end

  it "is invalid without a last name name" do
    # Setup the data
    contact = build(:contact, last_name: nil)
    # Validate something
    contact.valid?
    expect(contact.errors[:last_name]).to include("can't be blank")
  end

  it "is invalid without an email address" do
    # Setup the data
    contact = build(:contact, email: nil)
    # Validate something
    contact.valid?
    expect(contact.errors[:email]).to include("can't be blank")
  end

  it "is invalid with a duplicate email address" do
    # We want record in the database
    contact = create(:contact, email: "yo@email.com")
    # We need to build a contact
    contact = build(:contact, email: "yo@email.com")
    # Ask if valid
    contact.valid?
    # Test for any error messages
    expect(contact.errors[:email]).to include("has already been taken")
  end

  it "returns a contacts full name as a string" do
    contact = create(:contact)
    expect(contact.full_name).to eq "#{contact.first_name} #{contact.last_name}"
  end

  describe "filter last name by letter" do

    before :each do
      # Create a few contacts
      @tim = create(:contact, last_name: "Smith")
      @ben = create(:contact, last_name: "Jones")
      @john = create(:contact, last_name: "Johnson")
    end

    context "with matching letters" do
      it "returns a sorted array of results that match a given letter" do
        # Call method - contact.by_letter("J")
        # Validate only correct data returned
        expect(Contact.by_letter("J")).to eq [@john.last_name, @ben.last_name]
      end
    end

    context "with non matching letters" do
      it "returns a sorted array of results that match a given letter" do
        # Call method - contact.by_letter("J")
        # Validate only correct data returned
        expect(Contact.by_letter("J")).to_not eq [@tim.last_name]
      end
    end

  end

end
