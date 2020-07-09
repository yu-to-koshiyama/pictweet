require 'rails_helper'
# nicknameとemail、passwordとpassword_confirmationが存在すれば登録できる
describe User do
  describe '#create' do
    it "is valid " do
      user = build(:user)
      expect(user).to be_valid
    end

  # nicknameが空では登録できない
    it "is invalid with a nickname" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

  # emailが空では登録できない
    it "is invalid without a email" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

  # passwordが空では登録できない
    it "is invalid without a password" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

  # passwordが存在してもpassword_confirmationが空では登録できない
    it "doesn't match Password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

  # nicknameが7文字以上であれば登録できない

    it "is too long (maximum is 6 characters)" do
      user = build(:user, nickname: "1234567")
      user.valid?
      expect(user.errors[:nickname]).to include("is too long (maximum is 6 characters)")
    end

  # nicknameが6文字以下では登録できること
    it "is valid with a nickname that has less than 6 characters " do
      user = build(:user, nickname: "aaaaaa")
      expect(user).to be_valid
    end
  # 重複したemailが存在する場合登録できないこと
    it "is invalid with a duplicate email address" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end
  # passwordが6文字以上であれば登録できること
    it "is valid with a password that has more than 6 characters " do
      user = build(:user, password: "000000", password_confirmation: "000000")
      expect(user).to be_valid
    end

  # passwordが5文字以下であれば登録できないこと
    it "is invalid with a password that has less than 5 characters " do
      user = build(:user, password: "00000", password_confirmation: "00000")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end
  end
end



