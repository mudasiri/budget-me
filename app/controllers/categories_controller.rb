class CategoriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @categories = current_user.categories
  end

  def show
    @category = Category.find(params[:id])
    @total = @category.payments.sum(:amount)
    @payments = @category.payments.order(created_at: :desc)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.author_id = current_user.id
    if @category.save
      flash[:success] = 'Category succesfully added'
      redirect_to categories_path
    else
      flash[:error] = 'Error: Category could not be added'
      render :new
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:notice] = 'Category removed successfully'
    redirect_back(fallback_location: root_path)
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
