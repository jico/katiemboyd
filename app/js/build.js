(function() {
  var FANCYBOX_OPTIONS, FLICKR_PHOTOGRAPHY_SETS, FLICKR_PHOTOSET_CACHE, Flickr, FlickrPhoto, setId, setTitle, _fn;

  Flickr = (function() {
    var FLICKR_API_KEY, FLICKR_API_URL_BASE;

    FLICKR_API_URL_BASE = 'http://api.flickr.com/services/rest';

    FLICKR_API_KEY = '3c86aea4c40d6f0248bc5f223601811b';

    function Flickr(photosetId, photosetTitle) {
      this.photosetId = photosetId;
      this.photosetTitle = photosetTitle;
    }

    Flickr.prototype.photos = function() {
      var data, deferred;
      deferred = $.Deferred();
      data = {
        api_key: FLICKR_API_KEY,
        method: 'flickr.photosets.getPhotos',
        photoset_id: this.photosetId,
        format: 'json',
        nojsoncallback: 1
      };
      $.ajax({
        url: FLICKR_API_URL_BASE,
        data: data,
        jsonpCallback: "jsonFlickrApi" + this.photosetId,
        success: function(data) {
          var photoArr;
          photoArr = $.map(data.photoset.photo, function(photo) {
            return new FlickrPhoto(photo);
          });
          return deferred.resolve(photoArr, setTitle);
        },
        error: function(e) {
          return deferred.reject(e);
        }
      });
      return deferred.promise();
    };

    return Flickr;

  })();

  end;

  FlickrPhoto = (function() {
    var SIZE_SUFFIX;

    SIZE_SUFFIX = {
      square: 's',
      squareLarge: 'q',
      small: 'n',
      medium: 'c',
      large: 'b',
      original: 'o'
    };

    function FlickrPhoto(photoObj) {
      this.photoObj = photoObj;
    }

    FlickrPhoto.prototype.url = function(size) {
      var baseUrl, filename, sizeSuffix, urlResult;
      size || (size = 'large');
      sizeSuffix = SIZE_SUFFIX[size];
      baseUrl = "http://farm" + this.photoObj.farm + ".staticflickr.com";
      filename = "" + this.photoObj.id + "_" + this.photoObj.secret + "_" + sizeSuffix + ".jpg";
      return urlResult = [baseUrl, this.photoObj.server, filename].join('/');
    };

    return FlickrPhoto;

  })();

  end;

  FLICKR_PHOTOGRAPHY_SETS = {
    people: '72157640153601146',
    places: '72157640162925564',
    projects: '72157640160957355'
  };

  FLICKR_PHOTOSET_CACHE = {};

  FANCYBOX_OPTIONS = {
    helpers: {
      overlay: {
        css: {
          background: 'rgba(255,255,255,0.85)'
        }
      }
    }
  };

  $('#photography').on('click', '.gallery-cover', function() {
    var flickrSet, photos;
    flickrSet = $(this).data('flickr-set');
    photos = FLICKR_PHOTOSET_CACHE[flickrSet];
    return $.fancybox(photos, FANCYBOX_OPTIONS);
  });

  _fn = function(setTitle) {
    var container, cover, flickr;
    flickr = new Flickr(setId, setTitle);
    container = $(".gallery-container[data-flickr-set=" + setTitle + "]");
    cover = $(".gallery-cover[data-flickr-set=" + setTitle + "]");
    return flickr.photos().done(function(photos) {
      cover.css('background-image', "url(" + (photos[0].url('medium')) + ")");
      return FLICKR_PHOTOSET_CACHE[setTitle] = $.map(photos, function(photo) {
        return photo.url('large');
      });
    });
  };
  for (setTitle in FLICKR_PHOTOGRAPHY_SETS) {
    setId = FLICKR_PHOTOGRAPHY_SETS[setTitle];
    _fn(setTitle);
  }

}).call(this);
