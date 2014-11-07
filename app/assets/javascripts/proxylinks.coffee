#
# ctrl+click link proxies
#
$(document).on 'page:load ready', ->

  # dashboard listener
  $('.recent-content').on 'click', '[data-pmp]', (e) ->
    if e.ctrlKey || e.altKey || e.shiftKey
      e.preventDefault()
      window.open $(this).data('pmp'), '_blank'

  # search listener
  $('.pmp-search-form .results-list').on 'click', '[data-pmp]', (e) ->
    if e.ctrlKey || e.altKey || e.shiftKey
      e.preventDefault()
      window.open $(this).data('pmp'), '_blank'

  # non-shift-requiring links
  $('.pmp-search-form .results-list').on 'click', '[data-pmps]', (e) ->
    e.preventDefault()

    #  todo: only opening 1 works well
    href = $(this).data('pmps').split('|')[0]
    window.open(href, '_blank')
