class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
   @customers = Customer.all.page(params[:page]).per(10)
  end

  def show
   @customer = Customer.find(params[:id])
  end

  def edit
   @customer = Customer.find(params[:id])
  rescue ActiveRecord::RecordNotFound
     redirect_to admin_path, notice: "会員情報がありません"
  end


  def update
   @customer = Customer.find(params[:id])
   @customer.update(customer_params)
   redirect_to admin_customer_path
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :encrypted_password, :is_active)
  end

end

