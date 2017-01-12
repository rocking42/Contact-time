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

class Phone < ActiveRecord::Base
  belongs_to :contact
end
