(function() {
  var FLICKR_PHOTOGRAPHY_SETS, Flickr, FlickrPhoto, setId, setTitle, _fn;

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

  _fn = function(setTitle) {
    var container, flickr;
    flickr = new Flickr(setId, setTitle);
    container = $("[data-flickr-set=" + setTitle + "]");
    return flickr.photos().done(function(photos) {
      var anchor, photo, thumb, _i, _len;
      for (_i = 0, _len = photos.length; _i < _len; _i++) {
        photo = photos[_i];
        thumb = $('<img>').attr('src', photo.url('small'));
        anchor = $('<a>').attr({
          "class": 'fancybox',
          rel: setTitle,
          href: photo.url('large')
        }).append(thumb);
        container.append(anchor);
      }
      return $('.fancybox').fancybox();
    });
  };
  for (setTitle in FLICKR_PHOTOGRAPHY_SETS) {
    setId = FLICKR_PHOTOGRAPHY_SETS[setTitle];
    _fn(setTitle);
  }

}).call(this);
