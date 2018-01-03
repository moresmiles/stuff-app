class Item < ActiveRecord::Base
  belongs_to :owner
  belongs_to :move
  belongs_to :box
end
