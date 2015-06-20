$(document)
  .on 'click', '#edit-profile, #cancel-edit-profile', (e) ->
    e.preventDefault()
    
    $('#card, #edit_user').toggleClass('hide')
