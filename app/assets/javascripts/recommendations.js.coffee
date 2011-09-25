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

window.scrollVars = {}

scrollVars.contentHeight = 0
scrollVars.pageHeight = document.documentElement.clientHeight

window.displayCount = 0

categoryArray = ["list_art-print", "list_poster-art", "list_fragrance", "list_beer", "list_gin", "list_scotch", "list_vodka", "list_tequila", "list_rum", "list_liqueur", "list_bottle-of-wine", "cat_books", "list_magazine", "cat_tech", "cat_video-games", "list_basketball", "list_skateboard-shoe-brand", "list_soccer-jersey", "list_football", "list_skateboard-clothing-brand"]

$(document).ready ->
  getFriends ->
    setInterval ->
      if checkGetMore()
        loadFriends()
    , 250

getFriends = (cb) ->
  $.ajax
    url: '/birthdays'
    dataType: 'json'
    success: (data) ->
      window.friends = data
      cb()

loadFriends = (n = 10, cb = ->) ->
  end = displayCount + n
  end = friends.length if end > friends.length

  while (displayCount < end)
    friend = friends[displayCount]
    friend.index = displayCount
    displayCount++

    date = new Date friend.birthday_date
    friend.month = month[date.getMonth()]
    friend.day = date.getDate()

    $("#friendTemplate").tmpl(friend).hide().appendTo(".listContainer > ul").fadeIn ('100')

    loadItems(friend)

  cb()

loadItems = (friend) ->
  categories = randomSelection categoryArray, 5
  topics = makeTopicList categories

  $.ajax
    url: 'http://api.hunch.com/api/v1/get-recommendations'
    dataType: 'jsonp'
    data:
      user_id: "fb_#{friend.uid}"
      topic_ids: topics
    success: (data) ->
      recommendations = randomSelection data.recommendations, 5
      i = 0
      while (i < recommendations.length) and (i < 5)
        recommendations[i].index = i
        $("#itemTemplate").tmpl(recommendations[i]).hide().appendTo(".friend#{friend.index} ul").fadeIn('100')
        $(".friend#{friend.index} .item#{recommendations[i].index}").hover ->
          console.log $(this)
          $(".itemHover", this).fadeIn 'fast'
        , ->
          $(".itemHover", this).fadeOut 'fast'
        i++

checkGetMore = () ->
  if navigator.appName is "Microsoft Internet Explorer"
    scrollVars.position = document.documentElement.scrollTop
  else
    scrollVars.position = window.pageYOffset

  if (scrollVars.contentHeight - scrollVars.pageHeight - scrollVars.position) < 500
    scrollVars.contentHeight += 970
    return true
  else
    return false

randomSelection = (array, n) ->
  if array.length > n
    returnArray = []
    selectedIndex = {}
    while returnArray.length < n
      rand = Math.floor(Math.random() * array.length)
      if not selectedIndex[rand]?
        returnArray.push array[rand]
        selectedIndex[rand] = true
    return returnArray
  else
    return array

makeTopicList = (array) ->
  i = 0
  topicList = ""
  while (i < array.length)
    if i is 0
      topicList = "#{array[i]}"
    else
      topicList = "#{topicList},#{array[i]}"
    i++
  return topicList

