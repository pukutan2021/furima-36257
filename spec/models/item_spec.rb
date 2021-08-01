require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end

    describe '商品出品' do
      context '商品出品がうまくいくとき' do
        it '商品画像、商品名、商品の説明、カテゴリー、商品の状態、配送料の負担、
            発送元の地域、発送までの日数、価格、出品者が存在すれば出品できる' do
          expect(@item).to be_valid
        end
      end

      context '商品出品がうまくいかないとき' do
        it '商品画像を１枚つけることが必須である' do
          @item.image = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Image can't be blank")
        end

        it '商品名が必須である' do
          @item.name = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Name can't be blank")
        end

        it '商品の説明が必須である' do
          @item.info = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Info can't be blank")
        end

        it 'カテゴリーの情報が必須である' do
          @item.category_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Category can't be blank")
        end

        it 'カテゴリーが未選択の場合は登録できない' do
          @item.category_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Category can't be blank")
        end

        it '商品の状態の情報が必須である' do
          @item.sales_status_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Sales status can't be blank")
        end

        it '商品の状態が未選択の場合は登録できない' do
          @item.sales_status_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Sales status can't be blank")
        end

        it '配送料の負担の情報が必須である' do
          @item.shipping_fee_status_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Shipping fee status can't be blank")
        end

        it '配送料の負担が未選択の場合は登録できない' do
          @item.shipping_fee_status_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Shipping fee status can't be blank")
        end

        it '発送元の地域の情報が必須である' do
          @item.prefecture_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Prefecture can't be blank")
        end

        it '発送元の地域が未選択の場合は登録できない' do
          @item.prefecture_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Prefecture can't be blank")
        end

        it '発送までの日数の情報が必須である' do
          @item.scheduled_delivery_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Scheduled delivery can't be blank")
        end

        it '発送までの日数が未選択の場合は登録できない' do
          @item.scheduled_delivery_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Scheduled delivery can't be blank")
        end

        it '価格の情報が必須である' do
          @item.price = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Price can't be blank")
        end

        it '価格は全角文字では登録できない' do
          @item.price = 'あああ'
          @item.valid?
          expect(@item.errors.full_messages).to include('Price is invalid')
        end

        it '価格は半角英数混合では登録できない' do
          @item.price = '123aaa'
          @item.valid?
          expect(@item.errors.full_messages).to include('Price is invalid')
        end

        it '価格は半角英語だけでは登録できない' do
          @item.price = 'aaaaa'
          @item.valid?
          expect(@item.errors.full_messages).to include('Price is invalid')
        end

        it '価格は299円以下では登録できない' do
          @item.price = 299
          @item.valid?
          expect(@item.errors.full_messages).to include('Price is invalid')
        end

        it '価格は10,000,000円以上では登録できない' do
          @item.price = 10_000_000
          @item.valid?
          expect(@item.errors.full_messages).to include('Price is invalid')
        end

        it 'userが紐付いていないと出品できない' do
          @item.user = nil
          @item.valid?
          expect(@item.errors.full_messages).to include('User must exist')
        end
      end
    end
  end
end
