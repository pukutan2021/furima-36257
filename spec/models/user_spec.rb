require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'nickname,email,password,password_confirmation,last_name,first_name,
        last_name_kana,first_name_kana,birth_dateがあれば登録できること' do
      expect(@user).to be_valid
    end

    it 'nicknameが必須であること' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが必須であること' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'emailが一意性であること' do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'emailは、＠を含む必要があること' do
      @user.email = 'testtest.com'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it 'passwordが必須であること' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが６文字以上であれば登録できること' do
      @user.password = '123aaa'
      @user.password_confirmation = '123aaa'
      expect(@user).to be_valid
    end

    it 'passwordが5文字以下であれば登録できないこと' do
      @user.password = '123aa'
      @user.password_confirmation = '123aa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'passwordは半角英数字混合での入力が必須であること' do
      @user.password = '123456'
      @user.password_confirmation = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid')
    end

    it 'passwordとpassword_confirmationは、値の一致が必須であること' do
      @user.password = '123aaa'
      @user.password_confirmation = '1234aaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'パスワードは、全角文字では登録できないこと' do
      @user.password = '１２３aaa'
      @user.password_confirmation = '１２３aaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid')
    end

    it 'パスワードは、英字のみでは登録できないこと' do
      @user.password = 'aaaaaa'
      @user.password_confirmation = 'aaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is invalid')
    end

    it 'お名前(全角)は、名字が必須であること' do
      @user.last_name = '山田'
      expect(@user).to be_valid
    end

    it 'お名前(全角)は、名前が必須であること' do
      @user.first_name = '太郎'
      expect(@user).to be_valid
    end

    it 'お名前(全角)は、名字が空の場合に保存できないこと' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'お名前(全角)は、名前が空の場合に保存できないこと' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'お名前(全角)は、全角(漢字、ひらがな、カタカナ)での入力が必須であること' do
      @user.last_name = 'yamada'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name is invalid')
    end

    it 'お名前(全角)は、全角(漢字、ひらがな、カタカナ)での入力が必須であること' do
      @user.first_name = 'tarou'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name is invalid')
    end

    it 'お名前カナ(全角)は、名字が必須であること' do
      @user.last_name_kana = 'ヤマダ'
      expect(@user).to be_valid
    end

    it 'お名前カナ(全角)は、名前が必須であること' do
      @user.first_name_kana = 'タロウ'
      expect(@user).to be_valid
    end

    it 'お名前カナ(全角)は、名字が空の場合に保存できないこと' do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end

    it 'お名前カナ(全角)は、名前が空の場合に保存できないこと' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end

    it 'お名前カナ(全角)は、全角(カタカナ)での入力が必須であること' do
      @user.last_name_kana = 'yamada'
      @user.valid?
      expect(@user.errors.full_messages).to include('Last name kana is invalid')
    end

    it 'お名前カナ(全角)は、全角(カタカナ)での入力が必須であること' do
      @user.first_name_kana = 'tarou'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name kana is invalid')
    end

    it '生年月日が必須であること' do
      @user.birth_date = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth date can't be blank")
    end
  end
end
