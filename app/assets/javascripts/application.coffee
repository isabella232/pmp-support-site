#
# scripts manifest
#
#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require bootstrap
#= require bootbox
#= require_self
#= require_tree .
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

  # center modals
  $('body').on 'show.bs.modal', '.modal', ->
    $(this).css top: '50%', 'margin-top': -> -($(this).height() / 2)

  # logout modal
  $('.navbar .logout').on 'click', ->
    bootbox.dialog
      message: '<h3><i class="fa fa-spinner fa-spin"></i> Logging Out</h3>'
      closeButton: false
      className: 'bootbox-logout'
      animate: false
