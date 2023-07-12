require 'rails_helper'

RSpec.describe Category, type: :model do
  before :each do
    @user = User.create(name: 'test', password: 'testpass', email: 'test@test.com')
    @category = Category.new(name: 'test', icon: Rack::Test::UploadedFile.new('spec/support/image.jpg', 'image/jpg'))
  end

  describe 'validate data' do
    it 'it should have a name' do
      @category.name = nil
      expect(@category).to_not be_valid
    end

    it 'should have an icon image' do
      @category.icon = nil
      expect(@category).to_not be_valid
    end
  end
end
