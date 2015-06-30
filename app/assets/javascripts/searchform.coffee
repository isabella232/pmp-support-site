#
# PMP searcher, on whatever page
#
$(document).on 'page:load ready', ->
  return unless $('.pmp-search-form').length > 0

  getParam = (name) ->
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]")
    regex = new RegExp("[\\?&]" + name + "=([^&#]*)")
    if results = regex.exec(location.search)
      decodeURIComponent results[1].replace(/\+/g, ' ')
    else
      ''

  splitter = (name, fn) ->
    if raw = getParam(name)
      _.each raw.split(';'), fn

  updateShowMoreCheckboxes = ->
    _.each $('.more input:checked'), (el) ->
      $(el).closest('.with-more').addClass('showing')

  updateHasCheckboxes = ->
    profs = _.map $('.advanced input[name=profile]:checked'), (el) -> $(el).val()
    if profs.length == 1 && profs[0] == 'story'
      $('.contains input[value=story]').prop('checked', false).parent().hide()
      $('.contains').show()
    else if profs.length == 1 && profs[0] == 'episode'
      $('.contains input[value=story]').parent().show()
      $('.contains').show()
    else
      $('.advanced input[name=has]').prop('checked', false)
      $('.contains').hide()

  queryToForm = ->
    $('input[name=text]').val getParam('text')
    $('input[name=guid]').val getParam('guid')
    $('input[name=collection]').val getParam('collection')
    $('input[name=tag]').val getParam('tag')
    $('input[name=startdate]').val(getParam('startdate')).datepicker('update')
    $('input[name=enddate]').val(getParam('enddate')).datepicker('update')
    splitter 'profile', (type) ->
      $("input[name=profile][value=#{type}]").prop('checked', true)
    splitter 'has', (type) ->
      $("input[name=has][value=#{type}]").prop('checked', true)
    splitter 'creator', (name) ->
      $("input[name=creator][value=#{name}]").prop('checked', true)
    updateShowMoreCheckboxes()
    updateHasCheckboxes()

  formToQuery = (forProxy = false) ->
    getChecks = (name, valFn) ->
      _.map $(".pmp-search-form input[name=#{name}]:checked"), valFn
    params =
      advanced:   if $('.pmp-search-form .advanced.show-all').length && !forProxy then '1'
      searchsort: $('.pmp-search-form .sorts a.active').data('value')
      text:       $('.pmp-search-form input[name=text]').val()
      guid:       $('.pmp-search-form input[name=guid]').val()
      collection: $('.pmp-search-form input[name=collection]').val()
      tag:        $('.pmp-search-form input[name=tag]').val()
      startdate:  $('.pmp-search-form input[name=startdate]').val()
      enddate:    $('.pmp-search-form input[name=enddate]').val()
      profile:    getChecks 'profile', (el) -> $(el).val()
      has:        getChecks 'has', (el) -> $(el).val()
      creator:    getChecks 'creator', (el) -> if forProxy then $(el).data('guid') else $(el).val()
    _.each params, (val, key) ->
      if _.isEmpty(val)
        delete params[key]
      else if _.isArray(val)
        params[key] = val.join(';')
    encoded = _.map params, (val, key) -> "#{key}=#{encodeURIComponent(val)}"
    encoded.join('&')

  # push the url (if supported)
  setUrl = (makeNew = false) ->
    goto = window.location.href.split('?')[0] + '?' + formToQuery()
    if makeNew && history && history.pushState
      window.history.pushState({path: goto}, '', goto)
    else if history && history.replaceState
      window.history.replaceState({path: goto}, '', goto)

  # form handlers
  $('.advanced .toggle').click (e) ->
    e.preventDefault()
    if $('.advanced').hasClass('show-all')
      $('.advanced').removeClass('show-all')
    else
      $('.advanced').addClass('show-all')
    setUrl()
  $('.advanced input[name=profile]').change (e) ->
    e.preventDefault()
    updateHasCheckboxes()
  $('.toggle-more').click (e) ->
    e.preventDefault()
    $(this).closest('.with-more').addClass('showing')

  # dates
  dateOpts = autoclose: true, clearBtn: true, format: 'yyyy-mm-dd'
  $('.pmp-search-form #input-startdate').datepicker(dateOpts)
  $('.pmp-search-form #input-enddate').datepicker(dateOpts)

  # sorting
  $('.pmp-search-form .sorts a').click (e) ->
    e.preventDefault()
    unless $(this).hasClass('active')
      $('.pmp-search-form .sorts .active').removeClass('active')
      $(this).addClass('active')
      $('.pmp-search-form form').submit()

  # dashboard specific defaults
  $('body.dashboard input[name=profile][value=story]').prop('checked', true)
  $('body.dashboard input[name=has][value=image]').prop('checked', true)

  # dashboard specific handler (encode form, do redirect)
  $('body.dashboard .pmp-search-form form').submit (e) ->
    e.preventDefault()
    window.location = $(this).attr('action') + '?' + formToQuery()

  # search specific handler (search without redirect)
  $('body.search .pmp-search-form form').submit (e) ->
    e.preventDefault()
    setUrl(true)
    PMP.search.loadSearch(formToQuery(true))

  # search page handlers!
  if $('body.search').length > 0

    # infinite scrolling on the search results page
    $(window).scroll ->
      if PMP.search.loadNextTop
        if $(window).scrollTop() + $(window).height() >= PMP.search.loadNextTop
          PMP.search.loadNextTop = false
          PMP.search.loadNext()

    # colorbox
    $('.pmp-search-form .results-list').on 'click', '.expander.image', (e) ->
      e.preventDefault()
      $media = $(this).closest('.media')
      $media.find('.media-expanders a.image').colorbox
        rel: $media.data('guid')
        maxWidth: '80%'
        maxHeight: '90%'
        open: true
        close: '<i class="fa fa-times"></i>'
        next: '<i class="fa fa-arrow-circle-o-right"></i>'
        previous: '<i class="fa fa-arrow-circle-o-left"></i>'

    # kick off initial search
    queryToForm()
    PMP.search.loadSearch(formToQuery(true))
