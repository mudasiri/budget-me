require 'rails_helper'

RSpec.describe Payment, type: :model do
  before :each do
    @user = User.create(name: 'test', password: 'testpass', email: 'test@test.com')
    icon_file = fixture_file_upload('spec/support/image.jpg', 'image/jpeg')
    @category = Category.create(author: @user, name: 'Food', icon: icon_file)
    @payment = Payment.new(name: 'test', amount: 100)
  end

  describe 'validate data' do
    it 'it should have a name' do
      @payment.name = nil
      expect(@payment).to_not be_valid
    end

    it 'should have an amount' do
      @payment.amount = nil
      expect(@payment).to_not be_valid
    end

    it 'the amount should be numerical' do
      @payment.amount = 'a'
      expect(@payment).to_not be_valid
    end
  end
end
