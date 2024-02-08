class Public::CustomersController < ApplicationController
 before_action :authenticate_customer!

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  rescue ActiveRecord::RecordNotFound
     redirect_to root_path, notice: "会員情報がありません"
  end

  def update
    @customer = current_customer
    @customer.update(customer_params)
    redirect_to '/customers/my_page'
  end

  def unsubscribe
    @customer = current_customer
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

   private

  def customer_params
    params.require(:customer).permit(:name, :email, :encrypted_password, :password_confirmation)
  end

end
