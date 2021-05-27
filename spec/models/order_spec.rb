require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @order = FactoryBot.build(:order)
  end

  describe '商品購入' do
    context '商品購入できる時' do
      it '必要な情報を適切に入力すると、商品購入ができること' do
        expect(@order).to be_valid
      end

      it '建物名が入力されていなくても、商品購入ができること' do
        @order.buyer_building = ''
        expect(@order).to be_valid
      end

      it '電話番号が11桁なら、商品購入ができること' do
        @order.buyer_phone_number = '09012345678'
        expect(@order).to be_valid
      end
      it '電話番号が10桁なら、商品購入ができること' do
        @order.buyer_phone_number = '0901234567'
        expect(@order).to be_valid
      end
    end

    context '商品購入できない時' do
      it 'トークンが空（クレジットカード情報の入力が不完全）では購入できないこと' do
        @order.token = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Token can't be blank")
      end

      it '郵便番号が空では購入できないこと' do
        @order.buyer_postal_code = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Buyer postal code can't be blank")
      end
      it '郵便番号にハイフンがないと購入できないこと' do
        @order.buyer_postal_code = '1234567'
        @order.valid?
        expect(@order.errors.full_messages).to include('Buyer postal code にはハイフン(-)を含めて半角数字で入力してください')
      end
      it '郵便番号が全角数字では購入できないこと' do
        @order.buyer_postal_code = '１２３-４５６７'
        @order.valid?
        expect(@order.errors.full_messages).to include('Buyer postal code にはハイフン(-)を含めて半角数字で入力してください')
      end

      it '都道府県が空では購入できないこと' do
        @order.prefecture_id = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '都道府県が初期状態（idが1、nameが---）では購入できないこと' do
        @order.prefecture_id = 1
        @order.valid?
        expect(@order.errors.full_messages).to include('Prefecture には[---]以外を選択してください')
      end

      it '市区町村が空では購入できないこと' do
        @order.buyer_city = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Buyer city can't be blank")
      end

      it '番地が空では購入できないこと' do
        @order.buyer_address = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Buyer address can't be blank")
      end

      it '電話番号が空では購入できないこと' do
        @order.buyer_phone_number = ''
        @order.valid?
        expect(@order.errors.full_messages).to include("Buyer phone number can't be blank")
      end
      it '電話番号が12桁以上では購入できないこと' do
        @order.buyer_phone_number = '090123456789'
        @order.valid?
        expect(@order.errors.full_messages).to include('Buyer phone number には10桁もしくは11桁で入力してください')
      end
      it '電話番号が9桁以下では購入できないこと' do
        @order.buyer_phone_number = '090123456'
        @order.valid?
        expect(@order.errors.full_messages).to include('Buyer phone number には10桁もしくは11桁で入力してください')
      end
    end
  end
end
