class ApplicationController < ActionController::API
  include ErrorHandling

  private

  def default_render(*args)
    if request.format.json?
      action = action_name
      prefix = controller_path

      templates = lookup_context.find_all("#{prefix}/#{action}")

      if templates.present?
        super
      else
        render json: {
          status: response.status,
          message: @message || "",
          total: @total || 0,
          data: @data || []
        }
      end
    else
      super
    end
  end
end

