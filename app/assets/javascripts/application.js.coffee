#= require jquery
#= require jquery_ujs

#= require bootstrap-sprockets

#= require bootstrap-maxlength

#= require statuses

$(document).on 'keydown', 'textarea', (e) ->
  if e.keyCode is 13 and (e.metaKey or e.ctrlKey)
    $(@).parents('form').submit()
