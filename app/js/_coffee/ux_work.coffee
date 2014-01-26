FLICKR_UX_SETS =
  want:    '72157640173647766'
  hitlist: '72157640181141545'

FLICKR_UX_CACHE = {}

FANCYBOX_OPTIONS =
  helpers:
    overlay:
      css:
        background: 'rgba(255,255,255,0.85)'

$('#ux-work').on 'click', '.project-cover', ->
  flickrSet = $(@).data('flickr-set')
  photos    = FLICKR_UX_CACHE[flickrSet]
  $.fancybox(photos, FANCYBOX_OPTIONS)

for setTitle, setId of FLICKR_UX_SETS
  do (setTitle) ->
    flickr    = new Flickr(setId, setTitle)
    container = $(".project-container[data-flickr-set=#{setTitle}]")
    cover     = $(".project-cover[data-flickr-set=#{setTitle}]")

    flickr.photos().done (photos) ->
      FLICKR_UX_CACHE[setTitle] = $.map photos, (photo) ->
        return photo.url('large')
