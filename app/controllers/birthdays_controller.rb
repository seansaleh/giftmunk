require 'fql'

class BirthdaysController < ApplicationController
  def index
    fql = Fql.new(session[:access_token])
    puts session[:uid]
    puts session[:access_token]

    response = fql.query(
      "SELECT uid, name, birthday, birthday_date FROM user
      WHERE uid in (SELECT uid2 FROM friend WHERE uid1 = #{session[:uid]})
      AND strlen(birthday_date) != 0
      ORDER BY birthday desc")

    response.each do |user|
      dateToken = user["birthday_date"].split("/")
      user["birthday_date"] = Date.parse("#{dateToken[0]}/#{dateToken[1]}")

      difference = user["birthday_date"] - Date.today

      if difference < 0 then
        user["birthday_date"] = Date.new(user["birthday_date"].year + 1,
                                         user["birthday_date"].month,
                                         user["birthday_date"].day)
      end
      user["days_until"] = user["birthday_date"] - Date.today
    end

    response.sort! { |a, b| a["birthday_date"] <=> b["birthday_date"] }

    render :json => response
  end

end
