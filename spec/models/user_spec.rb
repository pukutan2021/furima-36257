require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it 'nickname,email,password,password_confirmation,last_name,first_name,
    last_name_kana,first_name_kana,birth_dateがあれば登録できること'
      expect(@user).to be_valid
    end

    it 'nicknameが必須であること'
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが必須であること'
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'emailが一意性であること'
      @user.save
      anether_user = FactoryBot.build(:user, email: @user.email)
      anether_user.valid?
      expect(anether_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'emailは、＠を含む必要があること'
      @user.email = "testtest.com"
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it 'passwordが必須であること'
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが６文字以上であれば登録できること'
      @user.password = '123aaa'
      @user.password_confirmation = '123aaa'
      expect(@user).to be_valid
    end

    it 'passwordが5文字以下であれば登録できないこと'
      @user.password = '1234a'
      @user.password_confirmation = '1234a'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short(minimun is 6 characters)')
    end

    it 'passwordは半角英数字混合での入力が必須であること'
      @user.password = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include('Password include both letters and numbers')
    end

    it 'passwordとpassword_confirmationは、値の一致が必須であること'
      @user.password = '12345a'
      @user.password_confirmation = '123456a'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'お名前(全角)は、名字と名前がそれぞれ必須であること'
      @user.last_name = "山田"
      @user.first_name = "太郎"
      expect(@user).to be_valid
    end

    it 'お名前(全角)は、全角(漢字、ひらがな、カタカナ)での入力が必須であること'
      @user.last_name = "yamada"
      @user.valid?
      expect(@user.errors.full_messages).to include("Last_name is invalid")
    end

    it 'お名前カナ(全角)は、名字と名前がそれぞれ必須であること'
      @user.last_name_kana = "ヤマダ"
      @user.first_name_kana = "タロウ"
      expect(@user).to be_valid
    end

    it 'お名前カナ(全角)は、全角(カタカナ)での入力が必須であること'
      @user.first_name_kana = "tarou"
      @user.valid?
      expect(@user.errors.full_messages).to include('First_name_kana is invalid')
    end

    it '生年月日が必須であること'
      @user.birth_date = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth_date can't be blank")
    end
  end
end