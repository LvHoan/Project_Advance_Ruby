module ErrorHandling
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    rescue_from ActionController::BadRequest, with: :render_bad_request
    rescue_from ActiveRecord::RecordNotDestroyed, with: :render_unprocessable_entity
  end

  private

  # 404
  def render_not_found(error)
    message = error.message || I18n.t("message.not_found.default").presence

    render json: { message: message }, status: :not_found
  end

  # 422
  def render_unprocessable_entity(error)
    render json: {
      message: error.message.presence,
    }, status: :unprocessable_entity
  end

  # 400
  def render_bad_request(error)
    render json: {
      message: error.message,
    }, status: :bad_request
  end
end
