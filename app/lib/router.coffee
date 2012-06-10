application = require 'application'
NewProjectsView = require 'views/new_project_view'
ProjectDetailView = require 'views/project_detail_view'
Project = require 'models/project'

module.exports = class Router extends Backbone.Router
  routes:
    ''               : 'home'
    'signup'         : 'signup'
    'new'            : 'newProject'
    'project/:id'    : 'project'

  home: ->
    $('#projects').html application.projectsView.render().el

  signup: ->
    router = this

    $('#signup').modal().on 'hide', ->
      router.navigate('')

  newProject: ->
    router = this
    view = new NewProjectsView
      projects: application.projects
      complete: (projectId) ->
        router.navigate('')

    $('body').append view.render().el

  project: (id) ->
    Project.load(id).done (project) ->
      view = new ProjectDetailView
        model: project
        el: $('#project')
    .fail ->
      console.log "Failed to retrieve project"
