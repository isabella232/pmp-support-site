#
# pmp searcher utilities
#
PMP.cache = {}
PMP.search =

  # root url for whichever proxy we're using
  proxyRoot: ->
    '/proxy/public'

  # cache search dependencies by href
  loadLink: (href) ->
    unless _.has(PMP.cache, href)
      PMP.cache[href] = false # loading indicator
      $.get("#{PMP.search.proxyRoot()}/#{href.replace(/http(s):\/\/[^\/]+\//, '')}")
        .fail (xhr, text, err) -> delete PMP.cache[href]
        .done (data, text, xhr) -> PMP.cache[href] = data

  # run a remote search (debounced)
  loadSearch: (queryString) ->
    $('.search-total').hide()
    PMP.search.template('working')
    $.get("#{PMP.search.proxyRoot()}/docs?#{queryString}")
      .fail(_.debounce(PMP.search.remoteFailure, 500))
      .done(_.debounce(PMP.search.remoteSuccess, 500))

  # something went wrong
  remoteFailure: (xhr, text, err) ->
    if xhr.status == 404
      $('.search-total').html('(0)').show()
      PMP.search.template('empty')
    else
      $('.search-total').hide()
      PMP.search.template('error', status: xhr.status, msg: err)

  # render results
  remoteSuccess: (data, text, xhr) ->
    if selfLink = _.find(data.links.navigation, (link) -> _.contains(link.rels, 'self'))
      $('.search-total').html("(#{selfLink.totalitems || 'unknown'})").show()
    else
      $('.search-total').html('(unknown)').show()
    PMP.search.template('row', data)

    linkDependencies = []
    _.each data.items, (item) ->
      linkDependencies.push PMP.search.loadLink(item.links.creator[0].href)
      if series = _.find(item.links.collection, (link) -> _.contains(link.rels, 'urn:collectiondoc:collection:series'))
        linkDependencies.push PMP.search.loadLink(series.href)
      if prop = _.find(item.links.collection, (link) -> _.contains(link.rels, 'urn:collectiondoc:collection:property'))
        linkDependencies.push PMP.search.loadLink(prop.href)
    $.when.apply($, linkDependencies).done ->
      PMP.search.template('row', data) # refresh with dependencies

  # render something
  template: (tpl, context) ->
    $('.results-list').html HandlebarsTemplates["search/#{tpl}"](context)
