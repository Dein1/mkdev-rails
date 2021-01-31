# frozen_string_literal: true

class ApplicationController < ActionController::Base
  add_flash_types :success, :danger, :warning

  before_action :update_allowed_parameters, if: :devise_controller?

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name last_name email password])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name last_name email password current_password])
  end
end
