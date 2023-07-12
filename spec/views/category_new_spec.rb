require 'rails_helper'

RSpec.describe 'Category', type: :feature do
  include Devise::Test::IntegrationHelpers
  describe 'New' do
    before(:each) do
      @user = User.create(name: 'dheeraj', email: 'dheerajarya@mail.com', password: 123_456)
      sign_in @user
      visit new_category_path
      fill_in 'Name', with: 'test group'
      attach_file('category_icon', Rails.root.join('spec', 'support', 'image.jpg'))
      click_button 'Create'
    end
    it 'Group name' do
      expect(page).to have_content('test group')
    end
    it 'Group Icon' do
      expect(page).to have_css('img[src*="image.jpg"]')
    end
  end
end
