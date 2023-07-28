class DaysToShip < ActiveHash::Base
  self.data = [
    { id: 0, name: '---' },
    { id: 1, name: '1~2日で発送' },
    { id: 2, name: '2~3日で発送' },
    { id: 3, name: 'お打ち合わせの上' },
    { id: 4, name: '8/11以降で発送' },
  ]

  include ActiveHash::Associations
  has_many :items

end