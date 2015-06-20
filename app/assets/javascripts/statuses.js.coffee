$('form#new-tweet')
  .on 'ajax:send', (xhr) ->
    $(@).find('textarea').attr('disabled', true)
  .on 'ajax:complete', (xhr, status) ->
    $(@).find('textarea').attr('disabled', false).focus()
  .on 'ajax:success', (data, status, xhr) ->
    $(@)
      .find('.form-group').removeClass('has-error').end()
      .find('p.text-danger').hide().end()
      .find('textarea').val('')
    $('[rel=tweets][data-refresh-url]').each -> $(@).data('reload')?()
  .on 'ajax:error', (xhr, status, error) ->
    $(@)
      .find('.form-group').addClass('has-error').end()
      .find('p.text-danger').html(status.responseJSON.errors.base[0]).show().end()

$('[rel=tweets][data-refresh-url]').each (_, elm) ->
  $(elm).data 'reload', ->
    $.rails.ajax
      method: 'GET'
      dataType: 'html'
      url: $(elm).data('refresh-url')
      beforeSend: -> $($(elm).data('loader')).removeClass('hide')
      success: (data) -> $(elm).html(data)
      complete: (jqXHR) -> $($(elm).data('loader')).addClass('hide')
  .data('reload')()

$(document).on 'click', 'a[rel=more]', (e) ->
  elm = $(@)
  
  e.preventDefault()
  $.rails.ajax
    method: 'GET'
    dataType: 'html'
    url: $(elm).attr('href')
    beforeSend: -> $(elm).hide().after('<i class="fa fa-circle-o-notch fa-spin"></i>')
    success: (data) -> $(elm).closest('.list-group-item').after(data)
    complete: (jqXHR) -> $(elm).closest('.list-group-item').remove()
