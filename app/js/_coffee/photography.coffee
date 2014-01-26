FLICKR_PHOTOGRAPHY_SETS =
  people:   '72157640153601146'
  places:   '72157640162925564'
  projects: '72157640160957355'

for setTitle, setId of FLICKR_PHOTOGRAPHY_SETS
  do (setTitle) ->
    flickr = new Flickr(setId, setTitle)
    container = $("[data-flickr-set=#{setTitle}]")

    flickr.photos().done (photos) ->
      for photo in photos
        thumb = $('<img>').attr('src', photo.url('small'))
        anchor = $('<a>').attr({
          class: 'fancybox'
          rel:   setTitle
          href:  photo.url('large')
        }).append(thumb)
        container.append(anchor)

      # TODO: Call this only once
      $('.fancybox').fancybox()
