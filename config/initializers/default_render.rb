# frozen_string_literal: true

class DefaultRender
  # Automatically render standard JSON for happy path
  def default_render(*args)
    if request.format.json?
      render partial: 'api/shared/standard_response',
             locals: {
               status: :ok,
               message: '',
               total: 0,
               data: controller_instance_data
             },
             status: :ok
    else
      super
    end
  end

  # Auto-detect main instance variable to render
  def controller_instance_data
    ivars = instance_variables - %i[@_response_body @_request @message @total]
    return nil if ivars.empty?

    instance_variable_get(ivars.first)
  end
end
