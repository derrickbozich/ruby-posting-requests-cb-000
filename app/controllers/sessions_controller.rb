class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    binding.pry
    resp = Faraday.get("https://foursquare.com/oauth2/access_token") do |req|
      req.params['client_id'] = ENV['FOURSQUARE_CLIENT_ID']
      req.params['client_secret'] = ENV['FOURSQUARE_SECRET']
      req.params['grant_type'] = 'authorization_code'
      # req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.params['redirect_uri'] = "http://165.227.16.205:47084/auth"
      req.params['code'] = params[:code]
    end
    binding.pry
    body = JSON.parse(resp.body)
    session[:token] = body["access_token"]
    redirect_to root_path
  end
end
