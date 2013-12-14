# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('#friend_name').autocomplete
    source: "/friends",
    minLength: 2

  $("#friend_submit").click (e) ->
    e.preventDefault()
    console.log "default prevented"
    $(".friends_list").children().append("<li>#{$('#friend_name').val()}</li>")