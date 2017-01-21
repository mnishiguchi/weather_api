# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  # With has_secure_password set up, we can register a user with a password:
  #   User.create email:    "user@example.com",
  #               password: "password",
  #               password_confirmation: "password"
  has_secure_password

  # https://github.com/nsarno/knock#customization
  def to_token_payload
    {
      sub:   id,
      email: email,
      admin: true
    }
  end
end
