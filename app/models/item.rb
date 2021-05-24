class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_charge
end
