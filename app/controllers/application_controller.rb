# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  
  before_action :ensure_json_request

  def ensure_json_request
    unless request.headers['Accept'] =~ /vnd\.api\+json/
      # render nothing: true, status: 406
      render json: { error: "The header 'Accept' must be defined or the type is not supported by the server" }, status: 406
    else
      unless request.get?
        return if request.headers['Content-Type'] =~ /vnd\.api\+json/
        render json: { error: "The header 'Content-Type' must be defined or the type is not supported by the server" }, status: 415
      end
    end
  end
end
