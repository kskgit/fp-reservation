class Customer::Base < ApplicationController
  private

  def current_customer
    return unless session[:customer_id]

    @current_customer ||=
      Customer.find_by(id: session[:customer_id])
  end

  helper_method :current_customer
end
