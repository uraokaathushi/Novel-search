# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  # before_action :reject_customer, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  def guest_login
    customer = Customer.guest
    sign_in(customer)
    flash[:notice] = "ゲストでログインしました。"
    redirect_to public_novels_path
  end

  def destroy_guest
    if current_customer.guest?
      current_customer.destroy
    end
    super
  end


  # POST /resource/sign_in
  # def create
  #   super
  # end
  def after_sign_in_path_for(resource)
   public_customer_my_page_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected
  # def reject_customer
  #   @customer = Customer.find_by(name: params[:customer][:name])
  #     if @customer
  #       if @customer.is_active
  #         redirect_to public_customer_my_page_path
  #       else
  #         flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
  #         redirect_to new_customer_registration_path
  #       end
  #     end
  # end

  # If you have extra params to permit, append them to the sanitizer.
   def configure_sign_in_params
     devise_parameter_sanitizer.permit(:sign_in, keys: [:name, :password])
   end


   def customer_state
     customer = Customer.find_by(email: params[:customer][:password][:name])
     return if customer.nil?
     return unless customer.valid_password?(params[:customer][:password][:name])
   end

  private

    def customer_params
     params.require(:customer).permit(:name, :email, :encrypted_password, :password_confirmation)
    end

end
