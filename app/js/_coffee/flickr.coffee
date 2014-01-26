class Flickr
  FLICKR_API_URL_BASE = 'http://api.flickr.com/services/rest'
  FLICKR_API_KEY      = '3c86aea4c40d6f0248bc5f223601811b'

  constructor: (@photosetId) ->

  photos: ->
    deferred = $.Deferred()

    data =
      api_key:     FLICKR_API_KEY
      method:      'flickr.photosets.getPhotos'
      photoset_id: @photosetId
      format:      'json'

    $.ajax
      url: FLICKR_API_URL_BASE,
      data: data
      dataType: 'jsonp'
      jsonpCallback: 'jsonFlickrApi'
      success: (data) ->
        photoArr = $.map data.photoset.photo, (photo) ->
          return new FlickrPhoto(photo)

        deferred.resolve(photoArr)
      error: (e) ->
        deferred.reject(e)

    return deferred.promise()

end

class FlickrPhoto
  SIZE_SUFFIX =
    square:      's' # 75x75
    squareLarge: 'q' # 150x150
    small:       'n' # 320 longest side
    medium:      'c' # 800 longest side
    large:       'b' # 1024 longest side
    original:    'o'

  constructor: (@photoObj) ->

  url: (size) ->
    size     ||= 'large'
    sizeSuffix = SIZE_SUFFIX[size]
    baseUrl    = "http://farm#{@photoObj.farm}.staticflickr.com"
    filename   = "#{@photoObj.id}_#{@photoObj.secret}_#{size}.jpg"
    urlResult  = [ baseUrl, @photoObj.server, filename ].join('/')
end
