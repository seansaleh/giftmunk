require 'fql'

class RecommendationsController < ApplicationController
  def index
    fql = Fql.new(session[:access_token])
    puts session[:uid]
    puts session[:access_token]

    response = fql.query(
      "SELECT uid, name, birthday_date FROM user
      WHERE uid in (SELECT uid2 FROM friend WHERE uid1 = #{session[:uid]})")
    puts response.inspect
  end

end
