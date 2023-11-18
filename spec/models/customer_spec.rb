require 'rails_helper'

RSpec.describe Customer, "モデルに関するテスト", type: :model do
  let!(:customer) { create(:customer) }

  describe "実際に保存してみる" do
    it "会員登録時に有効な内容の場合保存できるか" do
      expect(customer).to be_valid
    end
  end

  context "空白のバリデーションチェック" do
    it "first_nameが空白の場合バリデーションされ、エラーメッセージが返ってくるか" do
      customer.first_name = nil

      expect(customer).to be_invalid
      expect(customer.errors[:first_name]).to include("を入力してください") #完全一致
    end
  end

  context "文字数のチェック"do
    it "パスワードに文字数が足りない場合エラーメッセージが出るか" do
      customer.password = "abcd"

      expect(customer).to be_invalid
      expect(customer.errors[:password]).to include(/字以上/) #部分一致
    end
  end
end
