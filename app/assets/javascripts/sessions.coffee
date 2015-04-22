#
# login/logout/forgot/register pages
#
$(document).on 'page:load ready', ->

  # bootstrap-selects
  $('.hostpicker').selectpicker()
  $('.cmspicker').selectpicker()

  # fade the hint text
  $cmspicker = $('.bootstrap-select.cmspicker')
  $cmspicktxt = $cmspicker.find('.filter-option').addClass('text-muted')
  STARTTEXT = $cmspicktxt.text()
  $cmspicker.on 'show.bs.dropdown hide.bs.dropdown', ->
    if $cmspicktxt.text() == STARTTEXT
      $cmspicktxt.addClass('text-muted')
    else
      $cmspicktxt.removeClass('text-muted')
