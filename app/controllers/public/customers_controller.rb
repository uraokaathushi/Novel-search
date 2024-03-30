class Public::CustomersController < ApplicationController
 before_action :authenticate_customer!, :not_guest

  def show
    @customer = current_customer
    @novels = current_customer.novels
  end

  def edit
    @customer = current_customer
  rescue ActiveRecord::RecordNotFound
     redirect_to root_path, notice: "会員情報がありません"
  end

  def update
    @customer = current_customer
    @customer.update(customer_params)
    redirect_to public_customer_my_page_path
  end

  def unsubscribe
    @customer = current_customers
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_active: false)
    @customer.reload
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  def my_novel
    @novels = current_customer.novels
  end

   private

  def not_guest
     if current_customer && current_customer.email == 'guest@example.com'
       redirect_to root_path
     end
  end

  def customer_params
    params.require(:customer).permit(:name, :email, :encrypted_password, :password_confirmation)
  end

end
