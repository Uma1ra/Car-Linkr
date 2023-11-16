require 'rails_helper'

RSpec.describe "トップページからテスト" do
  let!(:customer) { create(:customer) }
  
  describe "ゲストではない会員が作成されているか" do
    
    it "会員が作成されているか" do
      expect(customer).to be_valid
    end
    
    it "ゲストじゃないこと" do
      expect(customer.is_guest).to eq(false)
    end
  end
  
end
