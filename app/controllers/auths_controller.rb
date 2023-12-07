class AuthsController < ApplicationController
  HMAC_SECRET = 'my$ecretK3y'
  
  def create
    payload = { name: params[:name] }
    token = JWT.encode(payload, HMAC_SECRET, 'HS256', exp: 24.hours.from_now.to_i )
    render json: { token: token }, status: :ok
  end
end
