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

# Views mapped as:
#   viewFilenameResult: yieldContent
views =
  index: 'about'

for view, _yield of views
  locals.yield = jade.renderFile "app/views/#{_yield}.jade", jadeOptions

  jade.renderFile "app/views/#{view}.jade", locals, (jadeErr, html) ->
    throw jadeErr if jadeErr

    fs.writeFile "public/#{view}.html", html, (fsErr) ->
      throw fsErr if fsErr
      console.log "Wrote #{view}.html yielding #{_yield}"
