class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
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
