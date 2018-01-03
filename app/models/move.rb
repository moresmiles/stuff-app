class Move < ActiveRecord::Base
  belongs_to :owner
  has_many :boxes
  has_many :items, through: :boxes
end
