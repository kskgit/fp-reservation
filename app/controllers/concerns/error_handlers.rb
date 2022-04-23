module ErrorHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :rescue500
    rescue_from ActiveRecord::RecordNotFound, with: :rescue404
    rescue_from ActionController::ParameterMissing, with: :rescue400
  end

  private

  def rescue500(_err)
    render 'errors/internal_server_error', status: :internal_server_error
  end

  def rescue404(_err)
    render 'errors/not_found', status: :not_found
  end

  def rescue400(_err)
    render 'errors/bad_request', status: :bad_request
  end
end
