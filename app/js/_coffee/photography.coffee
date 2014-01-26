FLICKR_PHOTOGRAPHY_SETS =
  people:
    id:      '72157640153601146'
    caption: false
  places:
    id:      '72157640162925564'
    caption: true
  projects:
    id:      '72157640160957355'
    caption: false

FLICKR_PHOTOSET_CACHE = {}

FANCYBOX_OPTIONS =
  helpers:
    overlay:
      css:
        background: 'rgba(255,255,255,0.85)'

$('#photography').on 'click', '.gallery-cover', ->
  flickrSet = $(@).data('flickr-set')
  photos    = FLICKR_PHOTOSET_CACHE[flickrSet]
  $.fancybox(photos, FANCYBOX_OPTIONS)

for setTitle, setOptions of FLICKR_PHOTOGRAPHY_SETS
  do (setTitle, setOptions) ->
    flickr    = new Flickr(setOptions.id, setTitle)
    container = $(".gallery-container[data-flickr-set=#{setTitle}]")
    cover     = $(".gallery-cover[data-flickr-set=#{setTitle}]")

    flickr.photos().done (photos) ->
      cover.css('background-image', "url(#{photos[0].url('medium')})")

      FLICKR_PHOTOSET_CACHE[setTitle] = $.map photos, (photo) ->
        fancyboxObj = { href: photo.url('large') }
        if setOptions.caption
          fancyboxObj.title = photo.title()
        return fancyboxObj
