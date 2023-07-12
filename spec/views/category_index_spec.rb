require 'rails_helper'

RSpec.describe 'Categories', type: :feature do
  include Devise::Test::IntegrationHelpers
  describe 'index' do
    before(:each) do
      @user = User.create(name: 'dheeraj', email: 'dheerajarya@mail.com', password: 123_456)
      sign_in @user
      icon_file = fixture_file_upload('spec/support/image.jpg', 'image/jpeg')
      @category = Category.create(author: @user, name: 'Food', icon: icon_file)
      @total = @category.payments.sum(:amount)
      visit categories_path
    end
    it 'renders name of category' do
      expect(page).to have_content(@category.name)
    end

    it 'displays the the icon' do
      expect(page).to have_selector('img[src*="image.jpg"]')
    end

    it 'renders total transaction of the category' do
      expect(page).to have_content(@total)
    end

    it 'renders remove button' do
      expect(page).to have_content('Remove')
    end

    it 'redirects to delete path' do
      click_button 'Remove'
      expect(page).to have_current_path(categories_path)
    end

    it 'renders a button to add category' do
      expect(page).to have_content('Add Category')
    end

    it 'redirects to a form for new category' do
      click_link 'Add Category'
      expect(page).to have_current_path(new_category_path)
    end
  end
end
