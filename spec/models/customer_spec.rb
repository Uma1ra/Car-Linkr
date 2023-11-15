require 'rails_helper'

RSpec.describe Customer, type: :model do
  it "会員登録時に有効な内容の場合保存できるか" do
    expect(FactoryBot.build(:customer)).to be_valid
  end
end
