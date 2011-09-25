require 'fb_graph'

class RecommendationsController < ApplicationController
  def index
    user = FbGraph::User.me(session[:access_token])

    @user = FbGraph::User.fetch(session[:uid])
  end

end
