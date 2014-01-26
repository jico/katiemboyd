_    = require 'lodash'
fs   = require 'fs'
jade = require 'jade'


jadeOptions =
  pretty: true

helpers =
  include: (filename) ->
    filename += '.jade' unless _.last(filename.split('.')) == 'jade'
    jade.renderFile filename, jadeOptions


locals = _.extend {}, helpers, jadeOptions


jade.renderFile 'app/views/index.jade', locals, (jadeErr, html) ->
  throw jadeErr if jadeErr

  fs.writeFile 'public/index.html', html, (fsErr) ->
    throw fsErr if fsErr
    console.log 'Wrote index.html:'
    console.log html
