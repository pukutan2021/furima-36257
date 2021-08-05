require 'rails_helper'

RSpec.describe OrderTransaction, type: :model do
  describe '#create' do
    before do
      item = FactoryBot.create(:item)
      user = FactoryBot.create(:user)
      @order_transaction = FactoryBot.build(:order_transaction, item_id: item.id, user_id: user.id)
    end

    describe '配送先情報の保存' do
      context '内容に問題ない場合' do
        it 'すべての値が正しく入力されていれば保存できること' do
          expect(@order_transaction).to be_valid
        end

        it '建物名は任意であること' do
          @order_transaction.building = ''
          expect(@order_transaction).to be_valid
        end
      end

      context '内容に問題がある場合' do
        it '郵便番号が必須であること' do
          @order_transaction.postal_code = ''
          @order_transaction.valid?
          expect(@order_transaction.errors.full_messages).to include("Postal code can't be blank")
        end

        it '郵便番号は、「3桁ハイフン4桁」の半角文字列のみ保存可能なこと' do
          @order_transaction.postal_code = '1234567'
          @order_transaction.valid?
          expect(@order_transaction.errors.full_messages).to include('Postal code is invalid')
        end

        it '都道府県が必須であること' do
          @order_transaction.prefecture_id = 1
          @order_transaction.valid?
          expect(@order_transaction.errors.full_messages).to include("Prefecture can't be blank")
        end

        it '市区町村が必須であること' do
          @order_transaction.city = ''
          @order_transaction.valid?
          expect(@order_transaction.errors.full_messages).to include("City can't be blank")
        end

        it '番地が必須であること' do
          @order_transaction.addresses = ''
          @order_transaction.valid?
          expect(@order_transaction.errors.full_messages).to include("Addresses can't be blank")
        end

        it '電話番号が必須であること' do
          @order_transaction.phone_number = ''
          @order_transaction.valid?
          expect(@order_transaction.errors.full_messages).to include("Phone number can't be blank")
        end

        it '電話番号は、10桁以上11桁以内の半角数値のみ保存可能なこと' do
          @order_transaction.phone_number = '090-1234-5678'
          @order_transaction.valid?
          expect(@order_transaction.errors.full_messages).to include('Phone number is invalid')
        end
      end
    end
  end
end
