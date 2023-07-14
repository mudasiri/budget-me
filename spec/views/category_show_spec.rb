require 'rails_helper'

RSpec.describe 'Categories', type: :feature do
  include Devise::Test::IntegrationHelpers
  describe 'Show' do
    before(:each) do
      @user = User.create(name: 'dheeraj', email: 'dheerajarya@mail.com', password: 123_456)
      sign_in @user
      icon_file = fixture_file_upload('spec/support/image.jpg', 'image/jpeg')
      @category = Category.create(author: @user, name: 'Food', icon: icon_file)
      @payment = Payment.create(author: @user, name: 'Pizza', amount: 50)
      @category.payments << @payment
      #   @payment.categories << @category
      @total = @category.payments.sum(:amount)
      visit category_path(@category.id)
    end
    it 'renders name of Payment' do
      expect(page).to have_content(@payment.name)
    end

    it 'renders total transaction of the category' do
      expect(page).to have_content(@total)
    end

    it 'renders amount of transaction' do
      expect(page).to have_content(@payment.amount)
    end

    it 'renders a button to add transaction' do
      expect(page).to have_content('Add Expense')
    end

    it 'redirects to a form for new transaction' do
      click_link 'Add Expense'
      expect(page).to have_current_path(new_category_payment_path(@category.id))
    end
  end
end
