class Owner < ActiveRecord::Base
  has_many :moves
  has_many :boxes, through: :moves
  has_many :items, through: :boxes
end
