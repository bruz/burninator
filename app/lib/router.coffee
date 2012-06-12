application = require 'application'
NewProjectView = require 'views/new_project_view'
ProjectDetailView = require 'views/project_detail_view'
NewTaskView = require 'views/new_task_view'
Project = require 'models/project'

module.exports = class Router extends Backbone.Router
  routes:
    ''                       : 'home'
    'signup'                 : 'signup'
    'projects/new'           : 'newProject'
    'projects/:id'           : 'project'
    'projects/:id/tasks/new' : 'newTask'

  home: ->
    $('#project').html('')
    @_loadSidebar()

  signup: ->
    router = this

    $('#signup').modal().on 'hide', ->
      router.navigate('', {trigger: true})

  newProject: ->
    @_loadSidebar()

    router = this
    view = new NewProjectView
      projects: application.projects
      complete: (projectId) ->
        router.navigate("projects/#{projectId}", {trigger: true})

    $('body').append view.render().el

  project: (id) ->
    @_loadSidebar(id)

    Project.load(id).done (project) ->
      view = new ProjectDetailView
        model: project
        el: $('#project')
        tab: 'tasks'
    .fail ->
      console.log "Failed to retrieve project"

  newTask: (id) ->
    @_loadSidebar(id)

    router = this
    view = new NewTaskView
      projectId: id
      complete: ->
        router.navigate("projects/#{id}", {trigger: true})

    $('body').append view.render().el

  _loadSidebar: (currentId) ->
    application.projectsView.currentId = currentId
    $('#projects').html application.projectsView.render().el
