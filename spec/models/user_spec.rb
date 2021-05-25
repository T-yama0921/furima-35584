require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmation、苗字名前の漢字とカタカナ、生年月日が存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'emailに「@」が含まれている場合登録できる' do
        @user.email = 'aaa@com'
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが英字と数字を共に含む6文字以上であれば登録できる' do
        @user.password = '0000aa'
        @user.password_confirmation = '0000aa'
        expect(@user).to be_valid
      end
      it 'last_nameが全角であれば登録できる' do
        @user.last_name = '山田'
        expect(@user).to be_valid
      end
      it 'first_nameが全角であれば登録できる' do
        @user.first_name = 'たろう'
        expect(@user).to be_valid
      end
      it 'last_name_kanaが全角カタカナであれば登録できる' do
        @user.last_name = 'ヤマダ'
        expect(@user).to be_valid
      end
      it 'first_nameが全角カタカナであれば登録できる' do
        @user.first_name = 'タロウ'
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailに「@」が含まれない場合登録できない' do
        @user.email = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '000aa'
        @user.password_confirmation = '000aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが英字のみでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて半角で設定してください')
      end
      it 'passwordが数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて半角で設定してください')
      end
      it 'passwordが全角では登録できない' do
        @user.password = '０００あああ'
        @user.password_confirmation = '０００あああ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて半角で設定してください')
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'last_nameが半角では登録できない' do
        @user.last_name = 'abc'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid. Input full-width characters.')
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
        it 'first_nameが半角では登録できない' do
          @user.first_name = 'abc'
          @user.valid?
          expect(@user.errors.full_messages).to include('First name is invalid. Input full-width characters.')
        end
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'last_name_kanaが半角では登録できない' do
        @user.last_name_kana = 'abc'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters.')
      end
      it 'last_name_kanaがカタカナではないなら登録できない' do
        @user.last_name_kana = '山田'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid. Input full-width katakana characters.')
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'first_name_kanaが半角では登録できない' do
        @user.first_name_kana = 'abc'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters.')
      end
      it 'first_name_kanaがカタカナではないなら登録できない' do
        @user.first_name_kana = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid. Input full-width katakana characters.')
      end
      it 'birth_dateが空では登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
