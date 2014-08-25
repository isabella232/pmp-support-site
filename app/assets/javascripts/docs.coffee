#
# api docs pages
#
$(document).on 'page:load ready', ->
  return unless $('body.docs').length > 0

  # translate markdown-syntax-highlighting-type to human readable name
  getLangName = (lang) ->
    switch lang
      when 'shell' then 'cURL'
      when 'json' then 'JSON'
      else lang.charAt(0).toUpperCase() + lang.slice(1)

  # group adjacent code blocks
  groupedLangs = []
  groupedCodes = []
  $('.markdown-content').find('pre > code').each ->
    $prev = $(this.parentNode).prev('pre')
    lang = this.className.replace(/highlight/, '').trim() || 'unknown'
    if $prev.length && $prev.children('code').length
      groupedLangs[groupedLangs.length - 1].push(lang)
      groupedCodes[groupedCodes.length - 1].push(this.parentNode)
    else
      groupedLangs.push([lang])
      groupedCodes.push([this.parentNode])

  # create tabs above each group
  for langs, idx in groupedLangs
    str = "<ul class='nav nav-tabs' role='tablist'>"
    for lang, lidx in langs
      if localStorage? && localStorage.activeLang in langs
        actv = if lang == localStorage.activeLang then 'active' else ''
      else
        actv = if lidx == 0 then 'active' else ''
      str += "<li class='#{actv}'><a href='#code-#{idx}-#{lidx}' class='code-#{lang}' role='tab' data-toggle='tab'>#{getLangName(lang)}</a></li>"
    $(str + '</ul>').insertBefore(groupedCodes[idx][0])

  # put code blocks into tab panes
  for blocks, idx in groupedCodes
    $(blocks).wrapAll("<div class='tab-content'></div>")
    langs = groupedLangs[idx]
    for block, bidx in blocks
      lang = langs[bidx]
      if localStorage? && localStorage.activeLang in langs
        actv = if lang == localStorage.activeLang then 'active' else ''
      else
        actv = if bidx == 0 then 'active' else ''
      $(block).wrap("<div class='tab-pane #{actv}' id='code-#{idx}-#{bidx}'></div>")

  # switch all tab panes on click (if possible)
  $window = $(window)
  $('.markdown-content .nav-tabs a').click (e) ->
    $this = $(this)
    offsetStart = $this.offset().top
    $(".markdown-content .#{$this.attr('class')}").not($this).tab('show')

    # scroll window back to the same place
    $window.scrollTop($window.scrollTop() + ($this.offset().top - offsetStart))

    # remember content types
    if localStorage?
      localStorage.activeLang = $this.attr('class').replace(/code-/, '')

  # create sidenav menu
  $sideNav = $('.docs-sidebar .nav')
  $('.markdown-content').find('h1').each (idx) ->
    $h1 = $(this)
    $h2s = $h1.nextUntil('h1', 'h2')
    actv = if idx == 0 then 'active' else ''
    $nav = $("<li class='#{actv}'><a href='##{$h1.attr('id')}' data-target='##{$h1.attr('id')}'>#{$h1.text()}</a></li>").appendTo($sideNav)
    if $h2s.length > 0
      $subnav = $('<ul class="nav"></ul>').appendTo($nav)
      $h2s.each ->
        $h2 = $(this)
        $subnav.append("<li><a href='##{$h2.attr('id')}' data-target='##{$h2.attr('id')}'>#{$h2.text()}</a></li>")

  # sidebar scrollspy
  $body = $(document.body)
  $body.scrollspy(target: '.docs-sidebar')
  $(window).on 'load', -> $body.scrollspy('refresh')

  # sidebar affixing
  $sideBar = $('.docs-sidebar')
  $sideBar.affix
    offset:
      top: -$sideBar.offset().top
      bottom: $('#footer').outerHeight(true)
