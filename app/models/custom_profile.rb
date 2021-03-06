# == Schema Information
#
# Table name: custom_profiles
#
#  id           :bigint           not null, primary key
#  birthplace   :string
#  introduction :text
#  nickname     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_custom_profiles_on_user_id  (user_id)
#
class CustomProfile < ApplicationRecord
  belongs_to :user

  has_one_attached :avatar
  has_one_attached :background
end
