require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @user = FactoryBot.build(:user, id: 1)
    @item = FactoryBot.build(:item, id: 1)
    @order = FactoryBot.build(:order, user_id: @user.id, item_id: @item.id)
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
        expect(@order.errors.full_messages).to include('クレジットカード情報を入力してください')
      end

      it '郵便番号が空では購入できないこと' do
        @order.buyer_postal_code = ''
        @order.valid?
        expect(@order.errors.full_messages).to include('郵便番号を入力してください')
      end
      it '郵便番号にハイフンがないと購入できないこと' do
        @order.buyer_postal_code = '1234567'
        @order.valid?
        expect(@order.errors.full_messages).to include('郵便番号はハイフン(-)を含めて半角数字で入力してください')
      end
      it '郵便番号が全角数字では購入できないこと' do
        @order.buyer_postal_code = '１２３-４５６７'
        @order.valid?
        expect(@order.errors.full_messages).to include('郵便番号はハイフン(-)を含めて半角数字で入力してください')
      end

      it '都道府県が空では購入できないこと' do
        @order.prefecture_id = ''
        @order.valid?
        expect(@order.errors.full_messages).to include('都道府県を入力してください')
      end
      it '都道府県が初期状態（idが1、nameが---）では購入できないこと' do
        @order.prefecture_id = 1
        @order.valid?
        expect(@order.errors.full_messages).to include('都道府県は[---]以外を選択してください')
      end

      it '市区町村が空では購入できないこと' do
        @order.buyer_city = ''
        @order.valid?
        expect(@order.errors.full_messages).to include('市区町村を入力してください')
      end

      it '番地が空では購入できないこと' do
        @order.buyer_address = ''
        @order.valid?
        expect(@order.errors.full_messages).to include('番地を入力してください')
      end

      it '電話番号が空では購入できないこと' do
        @order.buyer_phone_number = ''
        @order.valid?
        expect(@order.errors.full_messages).to include('電話番号を入力してください')
      end
      it '電話番号が12桁以上では購入できないこと' do
        @order.buyer_phone_number = '090123456789'
        @order.valid?
        expect(@order.errors.full_messages).to include('電話番号は半角数字のみを用いて10桁もしくは11桁で入力してください')
      end
      it '電話番号が9桁以下では購入できないこと' do
        @order.buyer_phone_number = '090123456'
        @order.valid?
        expect(@order.errors.full_messages).to include('電話番号は半角数字のみを用いて10桁もしくは11桁で入力してください')
      end
      it '電話番号が半角英数字混合では購入できないこと' do
        @order.buyer_phone_number = 'o9012345678'
        @order.valid?
        expect(@order.errors.full_messages).to include('電話番号は半角数字のみを用いて10桁もしくは11桁で入力してください')
      end
      it '電話番号が全角数字では購入できないこと' do
        @order.buyer_phone_number = '０９０１２３４５６７８'
        @order.valid?
        expect(@order.errors.full_messages).to include('電話番号は半角数字のみを用いて10桁もしくは11桁で入力してください')
      end

      it 'user_idが空では購入できないこと' do
        @order.user_id = ''
        @order.valid?
        expect(@order.errors.full_messages).to include('ユーザー情報を入力してください')
      end

      it 'item_idが空では購入できないこと' do
        @order.item_id = ''
        @order.valid?
        expect(@order.errors.full_messages).to include('商品情報を入力してください')
      end
    end
  end
end
