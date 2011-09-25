# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $.ajax
    url: '/birthdays'
    dataType: 'json'
    data:
      max: 10
    success: (data) ->

      $.each data, (index, value) ->
        value.index = index
        $("#birthdayTemplate").tmpl(value).appendTo("#birthdayList")
        $.ajax
          url: 'http://api.hunch.com/api/v1/get-recommendations'
          dataType: 'jsonp'
          data:
            user_id: "fb_#{value.uid}"
            topic_ids: "list_book"
          success: (data) ->
            console.log data

