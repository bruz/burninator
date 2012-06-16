View = require './view'
ProjectView = require './project_view'
template = require './templates/projects'

module.exports = class ProjectsView extends View
  template: template

  el: '#projects'

  initialize: (options) ->
    _.bindAll @, 'addAll', 'addOne'

    @projects = options.projects
    @projects.on 'reset', @render, @
    @projects.on 'add', @addOne, @

    @projects.fetch()

    @currentUser = Parse.User.current()

  afterRender: ->
    @addAll()

  update: (options) ->
    @currentId = options.currentId

    # re-render if user hasn't changed, otherwise full reload
    if @currentUser == Parse.User.current()
      @render()
    else
      @projects.fetch()

  addAll: ->
    @projects.each(@addOne)

  addOne: (project) ->
    className = if @currentId == project.id then "active" else ""

    view = new ProjectView
      model: project
      className: className
    $('#project-list').append(view.render().el)
