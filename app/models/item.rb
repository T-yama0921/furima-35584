class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_charges
  belongs_to :shipping_area
  belongs_to :shipping_days

  with_options presence: true do
    validates :image
    validates :name
    validates :description
    with_options numericality: { other_than: 0 } do
      validates :category_id
      validates :status_id
      validates :shipping_charges_id
      validates :shipping_area_id
      validates :shipping_days_id
    end
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  end
end
