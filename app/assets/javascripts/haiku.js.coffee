# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.app = window.app || {}

app.haiku = (()->
  errorHandler = (event) ->
    debugger

  $('.pretty_haiku embed').each (index, item) ->
    $item = $(item)
    $.ajax
      type: 'HEAD'
      crossDomain: true
      url: $item.data('src')
      error: (data, status, xhr) ->
        $item.attr("src", "http://localhost:3000/haiku_audio/#{$item.data('id')}.aiff")
      success: (data, status, xhr) ->
        $item.attr("src", $item.data('src'))
        parent = $item.parent()
        $item.remove()
        parent.append($item)

  return {
    errorHandler: errorHandler
  }
)()

jQuery ->
  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next_page').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').html("<div class='profile-block padded pagination-width'>Waiting for Haiku/ or maybe on Ohiro/ Who would really know?</div>")
        $.getScript(url)
    $(window).scroll()
