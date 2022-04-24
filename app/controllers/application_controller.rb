class ApplicationController < ActionController::Base
  layout :set_layout

  include ErrorHandlers if Rails.env.production?

  def set_layout
    if params[:controller].match(%r{\A(fp|customer)/})
      Regexp.last_match[1]
    else
      'customer'
    end
  end

  private :set_layout
end
