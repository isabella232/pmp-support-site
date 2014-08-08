#
# scripts manifest
#
#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require bootstrap
#= require bootbox
#

# turbolinks + google analytics workaround
if window.history?.pushState and window.history.replaceState
  $(document).on 'page:change', ->
    if window.ga?
      ga('set', 'location', location.href.split('#')[0])
      ga('send', 'pageview')
else
  $ -> ga('send', 'pageview') if window.ga? # turbolinks disabled

# ready listeners
$(document).on 'page:load ready', ->

  # set google analytics id fields
  if window.ga?
    ga (tracker) -> $('.ga-client-id').val(tracker.get('clientId'))

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

  # center modals
  $('body').on 'show.bs.modal', '.modal', ->
    $(this).css top: '50%', 'margin-top': -> -($(this).height() / 2)

  # create credentials
  $('.create-client').click (e) ->
    if $('.new-client-row').length == 1
      $('.new-client-row').clone(true).removeClass('hidden').appendTo('.table')
    $('.new-client-row').last().find('input').focus()
  $('.save-client').click (e) ->
    $row = $(e.target).closest('.new-client-row')
    $form = $row.find('.create-client-form')
    $form.find('#scope').val($row.find('.new-scope').val())
    $form.find('#label').val($row.find('.new-label').val())
    $form.find('#token_expires_in').val($row.find('.new-expires').val())
    $form.submit()
  $('.cancel-client').click (e) ->
    $('.new-client-row').last().remove()

  # destroy credentials
  $('.destroy-client').click (e) ->
    e.preventDefault()
    $form = $(e.target).closest('.actions').find('.destroy-client-form')
    bootbox.dialog
      message: '<strong>Really delete client?</strong><br/>This cannot be undone!'
      closeButton: false
      className: 'bootbox-confirm'
      buttons:
        cancel:
          label: 'Cancel'
          className: 'btn-default'
        yes:
          label: 'Delete'
          className: 'btn-danger'
          callback: ->
            $form.submit()
