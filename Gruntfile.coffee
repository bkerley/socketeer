module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    watch:
      scripts:
        files: '*.coffee'
        tasks: ['coffee']
    coffee:
      compile:
        files:
          'socketeer.js': 'socketeer.coffee'

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
