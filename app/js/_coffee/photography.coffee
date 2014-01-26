FLICKR_PHOTOGRAPHY_SETS =
  people:   '72157640153601146'
  places:   '72157640162925564'
  projects: '72157640160957355'

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

for setTitle, setId of FLICKR_PHOTOGRAPHY_SETS
  do (setTitle) ->
    flickr    = new Flickr(setId, setTitle)
    container = $(".gallery-container[data-flickr-set=#{setTitle}]")
    cover     = $(".gallery-cover[data-flickr-set=#{setTitle}]")

    flickr.photos().done (photos) ->
      cover.css('background-image', "url(#{photos[0].url('medium')})")

      FLICKR_PHOTOSET_CACHE[setTitle] = $.map photos, (photo) ->
        return photo.url('large')
