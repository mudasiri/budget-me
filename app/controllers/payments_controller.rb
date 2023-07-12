class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def new
    @payment = Payment.new
  end

  def create
    @payment = Payment.new(name: payment_params[:name], amount: payment_params[:amount])

    @payment.author_id = current_user.id
    if @payment.save
      CategoryPayment.create(payment: @payment, category_id: payment_params[:category_id])
      flash[:success] = 'Payment succesfully added'
      redirect_to category_path(payment_params[:category_id])
    else
      flash[:error] = 'Error: payment could not be added'
      render :new
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:name, :amount, :category_id)
  end
end
