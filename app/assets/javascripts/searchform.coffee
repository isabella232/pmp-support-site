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

  decomma = (name, fn) ->
    if raw = getParam(name)
      _.each raw.split(name), fn

  updateHasCheckboxes = ->
    profs = _.map $('.advanced input[name=profile]:checked'), (el) -> $(el).val()
    if profs.length == 1 && profs[0] == 'story'
      $('.contains').show()
    else
      $('.advanced input[name=has]').prop('checked', false)
      $('.contains').hide()

  queryToForm = ->
    $('input[name=text]').val getParam('text')
    $('input[name=tag]').val getParam('tag')
    decomma 'profile', (type) ->
      $("input[name=profile][value=#{type}]").prop('checked', true)
    decomma 'has', (type) ->
      $("input[name=has][value=#{type}]").prop('checked', true)
    decomma 'creator', (name) ->
      $("input[name=creator][value=#{name}]").prop('checked', true)
    updateHasCheckboxes()

  formToQuery = (forProxy = false) ->
    getChecks = (name, valFn) ->
      _.map $(".pmp-search-form input[name=#{name}]:checked"), valFn
    params =
      advanced: if $('.pmp-search-form .advanced').hasClass('show-all') && !forProxy then '1'
      text:     $('.pmp-search-form input[name=text]').val()
      tag:      $('.pmp-search-form input[name=tag]').val()
      profile:  getChecks 'profile', (el) -> $(el).val()
      has:      getChecks 'has', (el) -> $(el).val()
      creator:  getChecks 'creator', (el) -> if forProxy then $(el).data('guid') else $(el).val()
    _.each params, (val, key) ->
      if _.isEmpty(val)
        delete params[key]
      else if _.isArray(val)
        params[key] = val.join(';')
    encoded = _.map params, (val, key) -> "#{key}=#{encodeURIComponent(val)}"
    encoded.join('&')

  # form handlers
  $('.advanced .toggle').click (e) ->
    e.preventDefault()
    if $('.advanced').hasClass('show-all')
      $('.advanced .fields').slideUp(300).promise().done( -> $('.advanced').removeClass('show-all'))
    else
      $('.advanced .fields').slideDown(300).promise().done(-> $('.advanced').addClass('show-all'))
  $('.advanced input[name=profile]').change (e) ->
    e.preventDefault()
    updateHasCheckboxes()

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
    goto = window.location.href.split('?')[0] + '?' + formToQuery()
    if history && history.pushState
      window.history.pushState({path: goto}, '', goto)
    else
      # whatev
    PMP.search.loadSearch(formToQuery(true))

  # kick off initial search
  if $('body.search').length > 0
    queryToForm()
    PMP.search.loadSearch(formToQuery(true))
