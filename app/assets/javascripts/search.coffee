#
# pmp searcher
#

# root url for whichever proxy we're using
proxyRoot = ->
  '/proxy/public'

# cache search dependencies by href
PMP.cache = {}
loadLink = (href) ->
  unless _.has(PMP.cache, href)
    PMP.cache[href] = false # loading indicator
    $.get("#{proxyRoot()}/#{href.replace(/http(s):\/\/[^\/]+\//, '')}")
      .fail (xhr, text, err) -> delete PMP.cache[href]
      .done (data, text, xhr) -> PMP.cache[href] = data

# run a remote search (debounced)
loadSearch = (queryString) ->
  template('working')
  $.get("#{proxyRoot()}/docs#{queryString}")
    .fail(_.debounce(remoteFailure, 500))
    .done(_.debounce(remoteSuccess, 500))

# something went wrong
remoteFailure = (xhr, text, err) ->
  if xhr.status == 404
    template('empty')
  else
    template('error', status: xhr.status, msg: err)

# render results
remoteSuccess = (data, text, xhr) ->
  template('row', data)
  linkDependencies = []
  _.each data.items, (item) ->
    linkDependencies.push loadLink(item.links.creator[0].href)
    if series = _.find(item.links.collection, (link) -> _.contains(link.rels, 'urn:collectiondoc:collection:series'))
      linkDependencies.push loadLink(series.href)
    if prop = _.find(item.links.collection, (link) -> _.contains(link.rels, 'urn:collectiondoc:collection:property'))
      linkDependencies.push loadLink(prop.href)
  $.when.apply($, linkDependencies).done ->
    template('row', data) # refresh with dependencies

# render something
template = (tpl, context) ->
  $('.results-list').html HandlebarsTemplates["search/#{tpl}"](context)

# ready?
$(document).on 'page:load ready', ->
  return unless $('body.search').length > 0

  # assemble the query string
  getQueryString = ->
    inputs = {}
    if txt = $('input[name="text"]').val()
      inputs['text'] = txt
    inputs = _.map inputs, (val, key) -> "#{key}=#{encodeURIComponent(val)}"
    if inputs.length > 0 then "?#{inputs.join('&')}" else ''

  # searching
  $('form').submit (e) ->
    e.preventDefault()
    loadSearch(getQueryString())
  loadSearch(getQueryString())
