#
# login/logout/forgot/register pages
#
$(document).on 'page:load ready', ->

  # enable host picker
  $('.host-picker a').click (e) ->
    e.preventDefault()
    $target = $(e.target)
    $target.closest('.host-picker').find('.text').text($target.text())
    $target.closest('.host-picker').find('input').first().val($target.data('value'))

  # prevent bootstrap dropdown from stealing form-submit events
  preventDropdown = (e) ->
    if (e.which == 13)
      e.preventDefault()
      $(e.target).closest('form').submit()
  $('body.sessions form input').keypress(preventDropdown)
  $('body.password_reset form input').keypress(preventDropdown)
