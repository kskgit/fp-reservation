class Fp::Base < ApplicationController
  private

  def current_fp
    return unless session[:fp_id]

    @current_fp ||=
      Fp.find_by(id: session[:fp_id])
  end

  helper_method :current_fp
end
