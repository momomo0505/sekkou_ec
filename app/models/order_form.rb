# Formオブジェクト

#class OrderForm < ApplicationRecord（不要）
class OrderForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :city, :block, :building, :tel, :token

  with_options presence: true do
    validates :token
    validates :user_id
    validates :item_id
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ , message: 'はハイフンを含めた半角文字列で入力してください (例：123-4567)' }
    validates :city
    validates :block
    validates :tel, format: { with: /\A[0-9]{10,11}\z/, message: 'は10桁以上11桁以内の半角数値で入力してください' }
    validates :prefecture_id, numericality: { other_than: 0, message: "を入力してください" }
  end


def save
  order = Order.create(user_id: user_id, item_id: item_id)
   Address.create(order_id: order.id, post_code: post_code, prefecture_id: prefecture_id, city: city, block: block, building: building, tel: tel)
end
end