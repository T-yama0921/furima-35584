class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_charges
  belongs_to :shipping_area
  belongs_to :shipping_days

  with_options presence: true do
    varidates :image
    varidates :name
    varidates :description
    varidates :price, numericality: {greater_than_or_equal_to: 300, less_than_or_equal_to, 9999999}
    with_options numericality: { other_than: 0 } do
      varidates :category_id 
      varidates :status_id
      varidates :shipping_charges_id
      varidates :shipping_area_id
      varidates :shipping_days_id
    end
  end
end
