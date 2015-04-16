#
# pmp searcher utilities
#
PMP.cache = {}
PMP.search =

  # root url for whichever proxy we're using
  proxyRoot: ->
    '/proxy/public'

  # find a link by urn
  findLink: (item, urn) ->
    _.find _.flatten(_.values(item.links)), (link) ->
      _.contains(link.rels, urn)

  # attempt to get a proxy url
  proxyHref: (href) ->
    PMP.search.proxyRoot() + '/' + href.replace(/^http(s):\/\/[^\/]+\//, '')

  # attempt to get a total
  findTotalString: (item) ->
    selfLink = PMP.search.findLink(item, 'self')
    if item && item.attributes
      '1'
    else if selfLink && selfLink.totalitems?
      selfLink.totalitems.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
    else
      'unknown'

  # cache search dependencies by href
  loadLink: (href) ->
    unless _.has(PMP.cache, href)
      PMP.cache[href] = false # loading indicator
      $.get(PMP.search.proxyHref(href))
        .fail (xhr, text, err) -> delete PMP.cache[href]
        .done (data, text, xhr) -> PMP.cache[href] = data

  # run a remote search (debounced)
  loadSearch: (queryString) ->
    $('.search-total').hide()
    $('.results-list').html HandlebarsTemplates['search/working']()
    $.get(PMP.search.proxyHref("/docs?#{queryString}"))
      .fail(_.debounce(PMP.search.remoteFailure(), 500))
      .done(_.debounce(PMP.search.remoteSuccess(), 500))

  # load the next page (if it exists)
  loadNext: ->
    if $nextEl = $('.load-next-page').not('.loading')
      $nextEl.addClass('loading')
      href = $nextEl.data('href')
      $.get(PMP.search.proxyHref(href))
        .fail(PMP.search.remoteFailure(true))
        .done(PMP.search.remoteSuccess(true))

  # something went wrong
  remoteFailure: (append = false) ->
    (xhr, text, err) ->
      if append
        $('.load-next-page').remove()
        $('.results-list').append HandlebarsTemplates['search/error'](status: xhr.status, msg: err, asMedia: true)
      else
        if xhr.status == 404
          $('.search-total').html('(0)').show()
          $('.results-list').html HandlebarsTemplates['search/empty']()
        else
          $('.search-total').hide()
          $('.results-list').html HandlebarsTemplates['search/error'](status: xhr.status, msg: err)

  # render results
  remoteSuccess: (append = false) ->
    (data, text, xhr) ->
      if append
        $('.load-next-page').remove()
      else
        $('.search-total').html('(' + PMP.search.findTotalString(data) + ')').show()
        $('.results-list').html('')

      # handle single-guid searches
      if data && data.attributes
        data = {items: [data]}

      # render what we have now
      $el = $(HandlebarsTemplates['search/row'](data)).appendTo('.results-list')
      if offset = $('.load-next-page').offset()
        PMP.search.loadNextTop = offset.top

      # load dependencies and re-render
      linkDependencies = []
      _.each data.items, (item) ->
        linkDependencies.push PMP.search.loadLink(item.links.creator[0].href)
        if series = PMP.search.findLink(this, 'urn:collectiondoc:collection:series')
          linkDependencies.push PMP.search.loadLink(series.href)
        if prop = PMP.search.findLink(this, 'urn:collectiondoc:collection:property')
          linkDependencies.push PMP.search.loadLink(prop.href)
      $.when.apply($, linkDependencies).always ->
        $newEl = $(HandlebarsTemplates['search/row'](data))
        $el.replaceWith($newEl)

        # tooltips
        $newEl.find('.guid').tooltip().click (e) ->
          $(this).select().parent().find('.tooltip-inner').html('Ctrl+C to copy')
