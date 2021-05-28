require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context 'ユーザー登録できる時' do
      it '必要な情報を適切に入力すると、新規登録ができること' do
        expect(@user).to be_valid
      end
      it 'パスワードが6文字以上であれば登録できること' do
        @user.password = '123abc'
        @user.password_confirmation = '123abc'
        expect(@user).to be_valid
      end
      it 'パスワードが半角英数字混合での入力であれば登録できること' do
        @user.password = 'abc123'
        @user.password_confirmation = 'abc123'
        expect(@user).to be_valid
      end
    end

    context 'ユーザー登録できない時' do
      it 'ニックネームが空では登録できないこと' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームを入力してください')
      end

      it 'メールアドレスが空では登録できないこと' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレスを入力してください')
      end
      it '既に登録されているメールアドレスでは登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('メールアドレスはすでに存在します')
      end
      it 'メールアドレスに＠が含まれていないと登録できないこと' do
        @user.email = 'aaagmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレスは不正な値です')
      end

      it 'パスワードが空では登録できないこと' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください', 'パスワード（確認用）とパスワードの入力が一致しません')
      end
      it 'パスワードが5文字以下であれば登録できないこと' do
        @user.password = '123ab'
        @user.password_confirmation = '123ab'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'パスワードが半角英字のみでの入力であれば登録できないこと' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは英字と数字の両方を含めて設定してください')
      end
      it 'パスワードが半角数字のみでの入力であれば登録できないこと' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは英字と数字の両方を含めて設定してください')
      end
      it 'パスワードが全角の場合は登録できないこと' do
        @user.password = '全角パスワード'
        @user.password_confirmation = '全角パスワード'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは英字と数字の両方を含めて設定してください')
      end
      it 'パスワードのみ（パスワード(確認)が空）では登録できないこと' do
        @user.password = '123abc'
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end
      it 'パスワードとパスワード(確認)が不一致では登録できないこと' do
        @user.password = '123abc'
        @user.password_confirmation = '123abcd'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end

      it 'ユーザー本名が空では登録できないこと' do
        @user.last_name = ''
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前（名字）を入力してください', 'お名前（名前）を入力してください')
      end
      it 'ユーザー本名が全角（漢字・ひらがな・カタカナ）ではないと登録できないこと' do
        @user.last_name = 'Test'
        @user.first_name = 'Tarou'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前（名字）には全角文字を使用してください', 'お名前（名前）には全角文字を使用してください')
      end

      it 'ユーザー本名のフリガナが空では登録できないこと' do
        @user.last_name_kana = ''
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ（名字）を入力してください', 'お名前カナ（名前）を入力してください')
      end
      it 'ユーザー本名のフリガナが全角（カタカナ）ではないと登録できないこと' do
        @user.last_name_kana = 'てすと'
        @user.first_name_kana = '太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ（名字）には全角カナ文字を使用してください', 'お名前カナ（名前）には全角カナ文字を使用してください')
      end

      it '生年月日が空では登録できないこと' do
        @user.user_birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('生年月日を入力してください')
      end
    end
  end
end
