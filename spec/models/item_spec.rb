require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品新規出品' do
    context '商品出品できる時' do
      it '必要な情報を適切に入力すると、商品出品ができること' do
        expect(@item).to be_valid
      end
    end

    context '商品出品できない時' do
      it '商品画像が空では出品できないこと' do
        @item.item_image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('商品画像を入力してください')
      end

      it '商品名が空では出品できないこと' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品名を入力してください')
      end
      it '商品名が40文字を超えると出品できないこと' do
        @item.item_name = Faker::Lorem.paragraph_by_chars(number: 41, supplemental: false)
        @item.valid?
        expect(@item.errors.full_messages).to include('商品名は40文字以内で入力してください')
      end

      it '商品の説明が空では出品できないこと' do
        @item.item_description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の説明を入力してください')
      end
      it '商品の説明が1000文字を超えると出品できないこと' do
        @item.item_description = Faker::Lorem.paragraph_by_chars(number: 1001, supplemental: false)
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の説明は1000文字以内で入力してください')
      end

      it '商品のカテゴリー情報が空では出品できないこと' do
        @item.item_category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品のカテゴリーを入力してください')
      end
      it '商品のカテゴリー情報が初期状態（idが1、nameが---）では出品できないこと' do
        @item.item_category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('商品のカテゴリーは[---]以外を選択してください')
      end

      it '商品の状態についての情報が空では出品できないこと' do
        @item.item_status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態を入力してください')
      end
      it '商品の状態についての情報が初期状態（idが1、nameが---）では出品できないこと' do
        @item.item_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態は[---]以外を選択してください')
      end

      it '商品の配送料の負担についての情報が空では出品できないこと' do
        @item.item_shipping_fee_status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担を入力してください')
      end
      it '商品の配送料の負担についての情報が初期状態（idが1、nameが---）では出品できないこと' do
        @item.item_shipping_fee_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担は[---]以外を選択してください')
      end

      it '商品の発送元の地域についての情報が空では出品できないこと' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域を入力してください')
      end
      it '商品の発送元の地域についての情報が初期状態（idが1、nameが---）では出品できないこと' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域は[---]以外を選択してください')
      end

      it '商品の発送までの日数についての情報が空では出品できないこと' do
        @item.item_days_to_ship_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数を入力してください')
      end
      it '商品の発送までの日数についての情報が初期状態（idが1、nameが---）では出品できないこと' do
        @item.item_days_to_ship_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数は[---]以外を選択してください')
      end

      it '商品の販売価格についての情報が空では出品できないこと' do
        @item.item_price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格を入力してください')
      end
      it '商品の販売価格が¥300未満では出品できないこと' do
        @item.item_price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は半角数字のみを用いて300~9999999の範囲で入力してください')
      end
      it '商品の販売価格が¥9,999,999より大きいと出品できないこと' do
        @item.item_price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は半角数字のみを用いて300~9999999の範囲で入力してください')
      end
      it '商品の販売価格が全角数字では出品できないこと' do
        @item.item_price = '８７２４９６１'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は半角数字のみを用いて300~9999999の範囲で入力してください')
      end
      it '商品の販売価格が漢数字では出品できないこと' do
        @item.item_price = '二十九万八千六百'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は半角数字のみを用いて300~9999999の範囲で入力してください')
      end
      it '商品の販売価格が英字では出品できないこと' do
        @item.item_price = 'thirteen hundred and twenty'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は半角数字のみを用いて300~9999999の範囲で入力してください')
      end
    end
  end
end
