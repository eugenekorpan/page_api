class User < ActiveRecord::Base
  attr_accessible :password, :role, :username

  ADMIN = 'admin'
  CONTENT_PROVIDER = 'content_provider'

  validates :username, :password, :role, presence: true

  has_many :pages

  def admin?
    role == ADMIN
  end
end
