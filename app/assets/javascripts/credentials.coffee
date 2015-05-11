#
# cred pages
#
$(document).on 'page:load ready', ->

  # tooltip
  $('.readonly-tip i').tooltip
    placement: 'left'

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
