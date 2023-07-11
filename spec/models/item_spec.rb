require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
  context '出品が上手くいく時' do

    it '全ての入力事項が、存在すれば出品できる' do
      expect(@item).to be_valid
    end

    it '商品名が40文字以内で存在すれば出品できる' do
      @item.name = 'あ'
      expect(@item).to be_valid
    end

    it '商品の説明が存在すれば出品できる' do
      @item.description = 'あ'
      expect(@item).to be_valid
    end

    it 'カテゴリーが「---」以外であれば出品できる' do
      @item.category_id = 1
      expect(@item).to be_valid
    end

    it '商品の状態が「---」以外であれば出品できる' do
      @item.item_condition_id = 1
      expect(@item).to be_valid
    end

    it '配送料の負担が「---」以外であれば出品できる' do
      @item.shipping_charge_id = 1
      expect(@item).to be_valid
    end

    it '発送元の地域が「---」以外であれば出品できる' do
      @item.prefecture_id = 1
      expect(@item).to be_valid
    end

    it '発送までの日数が「---」以外であれば出品できる' do
      @item.days_to_ship_id = 1
      expect(@item).to be_valid
    end

    it '価格が半角数字でかつ300円〜9,999,999円であれば出品できる' do
      @item.price = 300
      expect(@item).to be_valid
    end

    it '価格が半角数字でかつ300円〜9,999,999円であれば出品できる' do
      @item.price = 9999999
      expect(@item).to be_valid
    end
  end


  context '出品が上手くいかない時' do
  
    it '画像がないと出品できない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it '商品名が空欄では出品できない' do
      @item.name = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end

    it '商品名が40文字以上であれば出品できない' do
      @item.name = 'あああああああああああああああああああああああああああああああああああああああああああ'
      @item.valid?
      expect(@item.errors.full_messages).to include("Name is too long (maximum is 40 characters)")
      
    end

    it '商品の説明が空欄だと出品できない' do
      @item.description = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Description can't be blank")
    end

    it 'カテゴリーに「---」が選択されているときは出品できない' do
      @item.category_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include('Category must be other than 0')
    end

    it '商品の状態に「---」が選択されているときは出品できない' do
      @item.item_condition_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include("Item condition must be other than 0")
    end

    it '配送料の負担に「---」が選択されているときは出品できない' do
      @item.shipping_charge_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include("Shipping charge must be other than 0")
    end

    it '発送元の地域に「---」が選択されているときは出品できない' do
      @item.prefecture_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include("Prefecture must be other than 0")
    end

    it '発送までの日数に「---」が選択されているときは出品できない' do
      @item.days_to_ship_id = 0
      @item.valid?
      expect(@item.errors.full_messages).to include("Days to ship must be other than 0")
    end

    it '価格が300円未満だと出品できない' do
      @item.price = 100
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
    end

    it '価格が9,999,999円より高いと出品できない' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
    end

    it '価格が正数でないと出品できない' do
      @item.price = 10_000_0.00
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be an integer')
    end

    it '価格が空欄だと出品できない' do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end

    it '価格に半角数字以外が含まれている場合は出品できない' do
      @item.price = "9０００"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is not a number")
    end

    it 'userが紐付いていなければ出品できない' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("User must exist")
    end
    
  end
  end
end
