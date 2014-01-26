(function() {
  var fs, helpers, jade, jadeOptions, locals, view, views, _, _yield;

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

  views = {
    index: 'about'
  };

  for (view in views) {
    _yield = views[view];
    locals["yield"] = jade.renderFile("app/views/" + _yield + ".jade", jadeOptions);
    jade.renderFile("app/views/" + view + ".jade", locals, function(jadeErr, html) {
      if (jadeErr) {
        throw jadeErr;
      }
      return fs.writeFile("public/" + view + ".html", html, function(fsErr) {
        if (fsErr) {
          throw fsErr;
        }
        return console.log("Wrote " + view + ".html yielding " + _yield);
      });
    });
  }

}).call(this);
