class ShippingCharge < ActiveHash::Base
  self.data = [
    { id: 0, name: '---' },
    { id: 1, name: '直接引取のみ、発送不可' },
    { id: 2, name: '発送可(送料込み)、直接引取可' },
    { id: 3, name: '発送のみ、直接引取不可' },
  ]

  include ActiveHash::Associations
  has_many :items

end