require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id)
    sleep 0.1
  end

  describe '商品購入' do
    context '商品購入できるとき' do
      it '全項目存在すれば購入できる' do
        expect(@order_address).to be_valid
      end
      it 'phone_numberが１１桁以内の数値なら購入できる' do
        @order_address.phone_number = '0123456789'
        expect(@order_address).to be_valid
      end
    end
    context '商品購入できないとき' do
      it 'postal_codeが空では購入できない' do
        @order_address.postal_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeがハイフン無しでは購入できない' do
        @order_address.postal_code = '0001111'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'postal_codeが半角英数字混合では購入できない' do
        @order_address.postal_code = '00a-1111'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'postal_codeが全角では購入できない' do
        @order_address.postal_code = '０００−１１１１'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
      end
      it 'shipping_area_idが0では購入できない' do
        @order_address.shipping_area_id = 0
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Shipping area must be other than 0')
      end
      it 'cityが空では購入できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it 'house_numberが空では購入できない' do
        @order_address.house_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("House number can't be blank")
      end
      it 'phone_numberが空では購入できない' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが全角では購入できない' do
        @order_address.phone_number = '０９０１２３４５６７８'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid.')
      end
      it 'phone_numberが半角英数字混合では購入できない' do
        @order_address.phone_number = 'a9012345678'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Phone number is invalid.')
      end
      it 'userが紐付いていなければ購入できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていなければ購入できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
