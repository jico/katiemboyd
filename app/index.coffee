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
  index:       'about'
  photography: 'photography'
  process:     'process'



for view, _yield of views
  jade.renderFile "app/views/#{_yield}.jade", jadeOptions, (jadeErr, yieldHtml) ->
    throw jadeErr if jadeErr
    locals.yield = yieldHtml

    jade.renderFile "app/views/index.jade", locals, (jadeErr, html) ->
      throw jadeErr if jadeErr

      fs.writeFile "public/#{view}.html", html, (fsErr) ->
        throw fsErr if fsErr
        console.log "Wrote #{view}.html yielding #{_yield}"
