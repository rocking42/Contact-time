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

class Contact < ActiveRecord::Base
  has_many :phones
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  # Instance method
  def full_name
    [first_name, last_name].join(" ")
  end

  def self.by_letter(letter)
    results = Contact.where("last_name LIKE ?", "#{letter}%").order(:last_name)
    test = []
    results.each { |item| test.push(item.last_name)}
    test
  end
end
