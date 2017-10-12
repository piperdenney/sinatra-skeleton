
require 'uri'
require "bcrypt"

class User < ActiveRecord::Base
  validates :email, presence: true, format: {with: URI::MailTo::EMAIL_REGEXP, message: 'only valid emails'}, uniqueness: true
  validates :user_name, presence: true
  has_many :posts


  def password
    @password ||= BCrypt::Password.new(hashed_password)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.hashed_password = @password
  end
end


