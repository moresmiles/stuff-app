class Box < ActiveRecord::Base
  belongs_to :owner
  belongs_to :move
  has_many :items
end
