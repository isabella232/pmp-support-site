#
# api docs pages
#
$(document).on 'page:load ready', ->
  return unless $('body.accounts').length > 0

  $('.change-password a').on 'click', (e) ->
    e.preventDefault()
    $('.change-password').addClass('changing')
    $('#input-password').focus()

  $('#input-password').on 'blur', (e) ->
    unless $(e.target).val()
      $('.change-password').removeClass('changing')

  $('#update-account-form').on 'submit', (e) ->
    $btn = $('#update-account-form .btn')
    $btn.attr('disabled', 'disabled')
    $btn.find('span').text('Updating')
    $btn.find('i').removeClass('fa-save').addClass('fa-spinner fa-spin')
