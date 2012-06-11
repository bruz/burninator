View = require './view'
ProjectView = require './project_view'
template = require './templates/projects'

module.exports = class ProjectsView extends View
  template: template

  initialize: (options) ->
    _.bindAll @, 'addAll', 'addOne'

    @projects = options.projects
    @projects.on 'reset', @addAll, @
    @projects.on 'add', @addOne, @

    @projects.fetch()

  afterRender: ->
    @addAll()

  addAll: ->
    @projects.each(@addOne)

  addOne: (project) ->
    className = if @currentId == project.id then "active" else ""

    view = new ProjectView
      model: project
      className: className
    @$('#project-list').append(view.render().el)
