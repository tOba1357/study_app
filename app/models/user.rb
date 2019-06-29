# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  uid                    :string
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
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable
  devise :omniauthable, omniauth_providers: %i[google_oauth2]

  has_many :word_cards

  class << self
    def from_omniauth(auth)
      user = User.find_by(uid: auth.uid, provider: auth.provider)
      if user.nil?
        user = User.create!(
            uid: auth.uid,
            provider: auth.provider,
            email: auth.info.email,
            password: Devise.friendly_token[0, 20]
        )
      end
      user
    end
  end
end
