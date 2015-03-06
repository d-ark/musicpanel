# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load' , ->
  playlist = new jPlayerPlaylist
    jPlayer: "#jquery_jplayer_1"
    cssSelectorAncestor: "#jp_container_1"
    window.playlist
    swfPath: "../dist/jplayer"
    supplied: "oga, mp3, m4a"
    wmode: "window"
    useStateClassSkin: true
    autoBlur: false
    smoothPlayBar: true
    keyEnabled: true


  ($ ".slider-range" ).each ->
    target = this.dataset['for']
    ($ this).slider
      range: true
      min: this.dataset['min'],
      max: this.dataset['max'],
      values: [($ "input[name='#{target}[from]']").val(), ($ "input[name='#{target}[to]']").val()],
      slide: (event, ui) ->
        $(".counter-for-#{this.dataset['for'].replace(/[\[\]]/g, '_')}").text "#{ui.values[ 0 ]} - #{ui.values[ 1 ]}"
        target = event.target.dataset['for']
        ($ "input[name='#{target}[from]']").removeAttr('disabled').val ui.values[ 0 ]
        ($ "input[name='#{target}[to]']").removeAttr('disabled').val ui.values[ 1 ]
        ($ this).closest('.filter').find('.disablable').removeClass 'disabled'


($ document).on 'click', '.disablable', ->
  $input = $("input[name^='#{this.getAttribute('for')}']")
  if ($ this).hasClass 'disabled'
    $input.removeAttr 'disabled'
    ($ this).removeClass 'disabled'
  else
    $input.attr 'disabled', true
    ($ this).addClass 'disabled'

($ document).on 'ready page:load', ->
  ($ '.disablable').each ->
    $input = $("input[name^='#{this.getAttribute('for')}']")
    if ($ this).hasClass 'disabled'
      $input.attr 'disabled', true
    else
      $input.removeAttr 'disabled'

