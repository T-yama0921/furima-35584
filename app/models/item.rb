class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_charges
  belongs_to :shipping_area
  belongs_to :shipping_days

  varidates :category_id, :status_id, :shipping_charges_id, :shipping_area_id, :shipping_days_id, numericality: { other_than: 1 } 
end
