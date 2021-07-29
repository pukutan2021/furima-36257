require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end

    describe '商品出品' do
      context '商品出品がうまくいくとき' do
        it '商品画像、商品名、商品の説明、カテゴリー、商品の状態、配送料の負担、
            発送元の地域、発送までの日数、価格が存在すれば出品できる' do
          expect(@item).to be_valid 
        end
      end

      context '商品出品がうまくいかないとき' do
        it '商品画像を１枚つけることが必須である' do
          @item.image = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Image must exist")
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
          expect(@item.errors.full_messages).to include("Category id can't be blank")
        end

        it '商品の状態の情報が必須である' do
          @item.sales_status_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Sales status id can't be blank")
        end

        it '配送料の負担の情報が必須である' do
          @item.shipping_fee_status_id = ''
          @item.valid?
          expect(@item.errors.full_messages)to include("Shipping fee status can't be blank")
        end

        it '発送元の地域の情報が必須である' do
          @item.prefecture_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Prefecture id can't be blank")
        end

        it '発送までの日数の情報が必須である' do
          @item.sheduled_delivery_id = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Scheduled delivery id can't be blank")
        end

        it '価格の情報が必須である' do
          @item.price = ''
          @item.valid?
          expect(@item.errors.full_messages).to include("Price can't be blank")
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
