class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code,
                :shipping_area_id,
                :city,
                :house_number,
                :building_name,
                :phone_number,
                :order_id,
                :user_id,
                :item_id

  with_options presence: true do
    validates :postal_code
    validates :shipping_area_id
    validates :city
    validates :house_number
    validates :phone_number
    validates :user_id
    validates :item_id
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(
      postal_code: postal_code,
      shipping_area_id: shipping_area_id,
      city: city,
      house_number: house_number,
      building_name: building_name,
      phone_number: phone_number,
      order_id: order.id
    )
  end
end