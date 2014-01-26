exec = require('child_process').exec
fs   = require('fs')
_    = require('lodash')

module.exports = (grunt) ->
  grunt.initConfig
    pkg:      grunt.file.readJSON('package.json')
    manifest: grunt.file.readJSON('manifest.json')
    coffee:
      compile:
        options:
          join: true
        files:
          'app/index.js':      'app/index.coffee'
          'app/js/build.js':   'app/js/_coffee/*.coffee'
    copy:
      fonts:
        expand: true
        flatten: true
        src: 'app/lib/font-awesome/fonts/*'
        dest: 'public/assets/fonts/'
      fancybox:
        expand: true
        flatten: true
        src: [ 'app/lib/fancybox/source/*.gif', 'app/lib/fancybox/source/*.png' ]
        dest: 'public/assets/css/'
    exec:
      node: 'node app/index.js'
    deploy:
      default:
        user: 'deploy'
        host: '***REMOVED***'
        path: '***REMOVED***'
      staging:
        user: 'deploy'
        host: '***REMOVED***'
        path: '***REMOVED***'
    less:
      production:
        options:
          paths:       ['css']
          yuicompress: true
        files: [
          {
            src:  '<%= manifest.css %>'
            dest: 'public/assets/css/app.css'
          }
        ]
    uglify:
      build:
        src: '<%= manifest.js %>'
        dest: 'public/assets/js/app.js'
    watch:
      coffee:
        files: [ 'index.coffee', 'app/js/_coffee/*.coffee' ]
        tasks: [ 'coffee', 'uglify', 'deploy:staging' ]
      assets:
        files: [ 'manifest.json' ]
        tasks: [ 'assets', 'deploy:staging' ]
      styles:
        files: 'app/css/**/*'
        tasks: [ 'less', 'deploy:staging' ]
      html:
        files: 'app/views/**/*'
        tasks: [ 'exec:node', 'deploy:staging' ]


  # Load task dependencies

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-contrib-less')
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-watch')

  # Custom tasks

  grunt.registerMultiTask 'exec', 'Execute system command', ->
    @data = [ @data ] unless _.isArray(@data)

    for command in @data
      grunt.log.writeln "Executing: #{command}"
      exec command, (err, stdout, stderr) ->
        throw err                if err?
        grunt.log.error stderr   if stderr?
        grunt.log.writeln stdout if stdout?

  grunt.registerMultiTask 'deploy', 'deploy via rsync', ->
    rsync = 'rsync --delete --progress --exclude=".*" -av -e ssh'
    src   = './'
    dest  = "#{@data.user}@#{@data.host}:#{@data.path}"

    command = "#{rsync} #{src} #{dest}"

    exec command, (err, stdout, stderr) ->
      throw err                if err?
      grunt.log.error stderr   if stderr?
      grunt.log.writeln stdout if stdout?

  # Register tasks

  grunt.registerTask('default', [ 'coffee', 'exec:node', 'uglify', 'less', 'copy' ])
  grunt.registerTask('assets',  [ 'uglify', 'less', 'copy' ])
