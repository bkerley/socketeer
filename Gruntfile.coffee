module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    watch:
      coffees:
        files: '*.coffee'
        tasks: ['coffee']
      hamls:
        files: 'public/*.haml'
        tasks: ['haml']
    coffee:
      compile:
        files:
          'socketeer.js': 'socketeer.coffee'
          'public/socketeer-client.js': 'socketeer-client.coffee'
    haml:
      dist:
        files:
          'public/index.html': 'public/index.html.haml'

  grunt.loadNpmTasks 'grunt-contrib-haml'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
