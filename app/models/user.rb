# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE)
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  has_one :basic_profile, dependent: :destroy
  has_one :custom_profile, dependent: :destroy

  delegate :birthday, :bday, :gender, :department, to: :basic_profile, allow_nil: true

  def display_name
    basic_profile&.name || self.email.split('@').first
  end

  def prepare_basic_profile
    basic_profile || build_basic_profile
  end

  def prepare_custom_profile
    custom_profile || build_custom_profile
  end

  def avatar_image
    if custom_profile&.avatar&.attached?
      custom_profile.avatar
    else
      'default-avatar.png'
    end
  end

  def background_image
    if custom_profile&.background&.attached?
      custom_profile.background
    else
      'l_e_others_500.png'
    end
  end
end
