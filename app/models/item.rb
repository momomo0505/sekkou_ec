class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_one :order
  has_many_attached :images

  belongs_to :category
  belongs_to :item_condition
  belongs_to :shipping_charge
  belongs_to :prefecture  
  belongs_to :days_to_ship


  with_options presence: true do
    validates :images
    validates :name, length: { maximum: 40 }
    validates :description, length: { maximum: 1000 }
    validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  end

  with_options numericality: { other_than: 0, message: "を入力してください" }do
  validates :category_id
  validates :item_condition_id
  validates :shipping_charge_id
  validates :prefecture_id
  validates :days_to_ship_id  
  end

end