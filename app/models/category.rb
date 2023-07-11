   class Category < ActiveHash::Base
    self.data = [
      { id: 0, name: '---' },
      { id: 1, name: '首像' },
      { id: 2, name: '胸像' },
      { id: 3, name: '半身像' },
      { id: 4, name: '幾何形体' },
    ]
  
    include ActiveHash::Associations
    has_many :items
    
    end