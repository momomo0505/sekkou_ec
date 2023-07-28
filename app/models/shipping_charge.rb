class ShippingCharge < ActiveHash::Base
  self.data = [
    { id: 0, name: '---' },
    { id: 1, name: '直接引取(発送不可)' },
    { id: 2, name: '発送(直接引取可)' },
    { id: 3, name: '発送もしくは直接引取' },
  ]

  include ActiveHash::Associations
  has_many :items

end