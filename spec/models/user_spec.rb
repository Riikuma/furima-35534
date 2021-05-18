require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do

    it "必要な情報を適切に入力すると、新規登録ができること" do
      expect(@user).to be_valid
    end

    it "ニックネームが空では登録できないこと" do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it "メールアドレスが空では登録できないこと" do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it "既に登録されているメールアドレスでは登録できないこと" do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end
    it "メールアドレスに＠が含まれていないと登録できないこと" do
      @user.email = 'aaagmail.com'
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it "パスワードが空では登録できないこと" do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it "パスワードが6文字以上であれば登録できること" do
      @user.password = '123abc'
      @user.password_confirmation = '123abc'
      expect(@user).to be_valid
    end
    it "パスワードが5文字以下であれば登録できないこと" do
      @user.password = '123ab'
      @user.password_confirmation = '123ab'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it "パスワードが半角英数字混合での入力であれば登録できること" do
      @user.password = 'abc123'
      @user.password_confirmation = 'abc123'
      expect(@user).to be_valid
    end
    it "パスワードが半角英字のみでの入力であれば登録できないこと" do
      @user.password = 'abcdef'
      @user.password_confirmation = 'abcdef'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
    end
    it "パスワードが半角数字のみでの入力であれば登録できないこと" do
      @user.password = '123456'
      @user.password_confirmation = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
    end
    it "パスワードのみ（パスワード(確認)が空）では登録できないこと" do
      @user.password = '123abc'
      @user.password_confirmation = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "パスワードとパスワード(確認)が不一致では登録できないこと" do
      @user.password = '123abc'
      @user.password_confirmation = '123abcd'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "ユーザー本名が空では登録できないこと" do
      @user.last_name = ''
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank", "First name can't be blank")
    end
    it "ユーザー本名が名字のみでは登録できないこと" do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
    it "ユーザー本名が名前のみでは登録できないこと" do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it "ユーザー本名が全角（漢字・ひらがな・カタカナ）ではないと登録できないこと" do
      @user.last_name = 'Test'
      @user.first_name = 'Tarou'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name には全角文字を使用してください", "First name には全角文字を使用してください")
    end

    it "ユーザー本名のフリガナが空では登録できないこと" do
      @user.last_name_kana = ''
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank", "First name kana can't be blank")
    end
    it "ユーザー本名のフリガナが名字のみでは登録できないこと" do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end
    it "ユーザー本名のフリガナが名前のみでは登録できないこと" do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end
    it "ユーザー本名のフリガナが全角（カタカナ）ではないと登録できないこと" do
      @user.last_name_kana = 'てすと'
      @user.first_name_kana = '太郎'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana には全角カナ文字を使用してください", "First name kana には全角カナ文字を使用してください")
    end

    it "生年月日が空では登録できないこと" do
      @user.user_birth_date = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("User birth date can't be blank")
    end

  end
end