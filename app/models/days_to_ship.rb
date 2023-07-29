class DaysToShip < ActiveHash::Base
  self.data = [
    { id: 0, name: '---' },
    { id: 1, name: '送料込み' },
    { id: 2, name: '送料別途' },
    { id: 3, name: 'ー' },
    { id: 4, name: '8/11以降で発送' },
  ]

  include ActiveHash::Associations
  has_many :items

end