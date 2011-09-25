# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

month = new Array(12)
month[0] = "Jan"
month[1] = "Feb"
month[2] = "Mar"
month[3] = "Apr"
month[4] = "May"
month[5] = "Jun"
month[6] = "Jul"
month[7] = "Aug"
month[8] = "Sep"
month[9] = "Oct"
month[10] = "Nov"
month[11] = "Dec"

$(document).ready ->
  $.ajax
    url: '/birthdays'
    dataType: 'json'
    data:
      max: 10
    success: (data) ->
      $.each data, (index, friend) ->
        friend.index = index
        
        date = new Date friend.birthday_date
        friend.month = month[date.getMonth()]
        friend.day = date.getDate()

        $("#friendTemplate").tmpl(friend).appendTo(".listContainer > ul")

        $.ajax
          url: 'http://api.hunch.com/api/v1/get-recommendations'
          dataType: 'jsonp'
          data:
            user_id: "fb_#{friend.uid}"
            topic_ids: "list_book"
          success: (data) ->
            recommendations = data.recommendations

            i = 0
            while (i < recommendations.length) and (i < 5)
              console.log recommendations[i]
              i++
              $("#itemTemplate").tmpl(recommendations[i]).appendTo(".friend#{index} ul")
      ###
      $.each data, (index, value) ->
        value.index = index
        console.log value
        $("#birthdayTemplate").tmpl(value).appendTo("#birthdayList")
        $.ajax
          url: 'http://api.hunch.com/api/v1/get-recommendations'
          dataType: 'jsonp'
          data:
            user_id: "fb_#{value.uid}"
            topic_ids: "cat_fashion"
          success: (data) ->
            # $("#birthday-#{index} .recommendations")
            recommendations = data.recommendations
            for recommendation in recommendations
              do (recommendation) ->
                $("#recommendationTemplate").tmpl(recommendation).appendTo("#birthday-#{index}")
      ###
