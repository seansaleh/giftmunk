class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    session[:uid] = user.uid
    session[:access_token] = auth["credentials"]["token"]
    puts user
    redirect_to "/recommendations"
  end

  def destroy
    reset_session

    redirect_to root_url
  end

end
