FLICKR_PHOTOGRAPHY_SETS =
  people:   '72157640153601146'
  places:   '72157640162925564'
  projects: '72157640160957355'

FLICKR_PHOTOSET_CACHE = {}

for setTitle, setId of FLICKR_PHOTOGRAPHY_SETS
  FLICKR_PHOTOSET_CACHE[setTitle] = new Flickr(setId)

FLICKR_PHOTOSET_CACHE.people.photos().done (data) ->
  console.log data
