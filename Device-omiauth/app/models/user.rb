class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :omniauthable, omniauth_providers: [:google_oauth2]

  def self.find_for_google_oauth2(access_token, signed_in_resource = nil)
    email = access_token.info['email']
    User.where(email: email).first_or_create do |user|
      user.password = user.password_confirmation = Devise.friendly_token
      user.save
    end
  end
end
