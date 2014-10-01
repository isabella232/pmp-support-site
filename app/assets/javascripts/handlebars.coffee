#
# handlebars helpers
#

getProfile = (item) ->
  if item && item.links && item.links.profile && item.links.profile.length
    if item.links.profile[0].href.match(/\/profiles\//)
      _.last(item.links.profile[0].href.split('/'))
    else
      'unknown'
  else
    'unknown'

getItemOfProfile = (item, profileType) ->
  if getProfile(item) == profileType
    item
  else
    _.find(item.items, (child) -> getProfile(child) == profileType)

getLinkOfUrn = (item, urn) ->
  _.find _.flatten(_.values(item.links)), (link) ->
    _.contains(link.rels, urn)

getCachedTitle = (link) ->
  if PMP.cache[link.href]
    PMP.cache[link.href].attributes.title
  else
    link.title # a big "maybe"

ellipsis = (str, limit) ->
  if str.length > limit
    str = str.substr(0, limit-1)
    str = str.substring(0, str.lastIndexOf(' '))
    str + '&hellip;'
  else
    str

Handlebars.registerHelper 'item-img', (options) ->
  if img = getItemOfProfile(this, 'image')
    options.fn(img)
  else
    options.inverse(this)

Handlebars.registerHelper 'item-series', (options) ->
  best =
    if series = getLinkOfUrn(this, 'urn:collectiondoc:collection:series')
      ['Series', series.href, getCachedTitle(series)]
    else if prop = getLinkOfUrn(this, 'urn:collectiondoc:collection:property')
      ['Property', prop.href, getCachedTitle(prop)]
    else if this.links.creator && this.links.creator.length
      ['Creator', this.links.creator[0].href, getCachedTitle(this.links.creator[0])]
  if best
    options.fn(type: best[0], href: best[1], title: best[2])
  else
    options.inverse(this)

Handlebars.registerHelper 'item-types', (options) ->
  type  = getProfile(this)
  types = [type].concat _.uniq(_.map(this.items, getProfile)).sort()
  caps  = _.map types, (t) -> t.charAt(0).toUpperCase() + t.slice(1)
  len   = false # TODO: not available in any current data
  options.fn(classes: types.join(' '), label: caps.join(' + '), length: len)

Handlebars.registerHelper 'item-author', (options) ->
  if this.attributes.byline
    options.fn(name: this.attributes.byline)
  else if this.links.author && this.links.author.length
    options.fn(name: this.links.author[0].title)
  # TODO: better

Handlebars.registerHelper 'item-attachments', (options) ->
  attachs = {}
  _.each _.map(this.items, getProfile), (type) ->
    attachs[type] = (attachs[type] || 0) + 1
  rets = _.map _.keys(attachs).sort(), (type) ->
    label = type.charAt(0).toUpperCase() + type.slice(1)
    if attachs[type] != 1
      label = switch label
        when 'Story' then 'Stories'
        when 'Image' then 'Images'
        when 'Audio' then 'Audio'
        else label + 's'
    options.fn(count: attachs[type], type: label)
  rets.join('')

Handlebars.registerHelper 'fancy-date', (dateStr) ->
  if date = new Date(dateStr)
    date.toDateString()
  else
    dateStr

Handlebars.registerHelper 'description', (attrs) ->
  if best = attrs.teaser || attrs.description || attrs.contentencoded
    new Handlebars.SafeString ellipsis(best, 400)

Handlebars.registerHelper 'img-thumb', (context, options) ->
  best = _.first(context).href
  _.find ['small', 'thumb', 'standard', 'primary'], (cropType) ->
    _.find context, (encl) ->
      if encl && encl.meta && encl.meta.crop == cropType
        best = encl.href
  new Handlebars.SafeString(best)
