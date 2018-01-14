class Owner < ActiveRecord::Base
  has_many :moves
  has_many :boxes, through: :moves
  has_many :items, through: :boxes

  has_secure_password

  EMAIL_REGEX = /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\Z/i
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX

end
