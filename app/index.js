(function() {
  var fs, helpers, jade, jadeOptions, locals, _;

  _ = require('lodash');

  fs = require('fs');

  jade = require('jade');

  jadeOptions = {
    pretty: true
  };

  helpers = {
    include: function(filename) {
      if (_.last(filename.split('.')) !== 'jade') {
        filename += '.jade';
      }
      return jade.renderFile(filename, jadeOptions);
    }
  };

  locals = _.extend({}, helpers, jadeOptions);

  jade.renderFile('app/views/index.jade', locals, function(jadeErr, html) {
    if (jadeErr) {
      throw jadeErr;
    }
    return fs.writeFile('public/index.html', html, function(fsErr) {
      if (fsErr) {
        throw fsErr;
      }
      console.log('Wrote index.html:');
      return console.log(html);
    });
  });

}).call(this);
