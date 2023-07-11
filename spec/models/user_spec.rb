require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
  context '新規登録が上手くいく時' do

    it '全ての入力事項が、存在すれば登録できる' do
     expect(@user).to be_valid
    end

    it 'パスワードが6文字以上半角英数字であれば登録できる' do
      @user.password = '123abc'
      @user.password_confirmation = '123abc'
      expect(@user).to be_valid
    end

    it '名字が全角（漢字・ひらがな・カタカナ）であれば登録できる' do
      @user.last_name = '藤田'
      expect(@user).to be_valid
    end

    it '名前が全角（漢字・ひらがな・カタカナ）であれば登録できる' do
      @user.first_name = '崇嗣'
      expect(@user).to be_valid
    end

  end
  
  context '新規登録が上手くいかない時' do
  
    it 'nicknameが空欄では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it '重複したemailが存在する場合は登録できない' do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'emailが空欄では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'emailは@を含まないと登録できない' do
      @user.email = 'testmail'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it 'passwordが空欄では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが5文字以下であれば登録できない' do
      @user.password = '00000'
      @user.password_confirmation = '00000'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'passwordが英字のみのパスワードでは登録できない' do
      @user.password = 'aaaaaa'
      @user.password_confirmation = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password は6文字以上の半角英数字で入力してください")
    end

    it 'passwordが数字のみのパスワードでは登録できない' do
      @user.password = '111111'
      @user.password_confirmation = '111111'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password は6文字以上の半角英数字で入力してください")
    end

    it 'passwordに全角文字が含まれていると登録できない' do
      @user.password = '１23abac'
      @user.password_confirmation = '１23abac'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password は6文字以上の半角英数字で入力してください")
    end

    it 'passwordとpassword_confirmationが不一致では登録できない' do
      @user.password = '123456'
      @user.password_confirmation = '1234567'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it '名字が全角（漢字・ひらがな・カタカナ）でないと登録できない' do
      @user.last_name = 'fujita'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name is invalid')
    end

    it '名前が全角（漢字・ひらがな・カタカナ）でないと登録できない' do
      @user.first_name = 'takashi'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name is invalid')
    end

    it '名字が空欄では登録できない' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it '名前が空欄では登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

  end
end
end