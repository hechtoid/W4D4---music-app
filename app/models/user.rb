# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  sessin_tokin    :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
after_initialize :ensure_sessin_tokin

def self.generate_sessin_tokin
	SecureRandom.urlsafe_base64
end

def reset_sessin_tokin!
	self.sessin_tokin = User.generate_sessin_tokin
	self.save!
	self.sessin_tokin
end

def ensure_sessin_tokin
	self.sessin_tokin ||= User.generate_sessin_tokin
end

def password=(password)
	@password = password
	self.password_digest = BCrypt::Password.create(password)
end

def is_password?(password)
	BCrypt::Password.new(self.password_digest).is_password?(password)
end



end
