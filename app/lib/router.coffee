application = require 'application'

module.exports = class Router extends Backbone.Router
  routes:
    ''               : 'home'
    'new'            : 'newProject'

  home: ->
    $('#projects').html application.projectsView.render().el

  newProject: ->
    router = this

    $('#project-add').modal().on 'hide', ->
      router.navigate('')
