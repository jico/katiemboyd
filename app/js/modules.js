(function() {
  var Flickr, FlickrPhoto;

  Flickr = (function() {
    var FLICKR_API_KEY, FLICKR_API_URL_BASE;

    FLICKR_API_URL_BASE = 'http://api.flickr.com/services/rest';

    FLICKR_API_KEY = '3c86aea4c40d6f0248bc5f223601811b';

    function Flickr(photosetId) {
      this.photosetId = photosetId;
    }

    Flickr.prototype.fetchPhotoset = function() {
      var data, deferred;
      deferred = $.Deferred();
      data = {
        api_key: FLICKR_API_KEY,
        method: 'flickr.photosets.getPhotos',
        photoset_id: this.photosetId,
        format: 'json'
      };
      $.ajax({
        url: FLICKR_API_URL_BASE,
        data: data,
        dataType: 'jsonp',
        jsonpCallback: 'jsonFlickrApi',
        success: function(data) {
          var photoArr;
          photoArr = $.map(data.photoset.photo, function(photo) {
            return new FlickrPhoto(photo);
          });
          return deferred.resolve(photoArr);
        },
        error: function(e) {
          return deferred.reject(e);
        }
      });
      return deferred;
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
      filename = "" + this.photoObj.id + "_" + this.photoObj.secret + "_" + size + ".jpg";
      return urlResult = [baseUrl, this.photoObj.server, filename].join('/');
    };

    return FlickrPhoto;

  })();

  end;

}).call(this);
