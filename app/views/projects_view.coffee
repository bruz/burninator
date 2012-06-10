View = require './view'
ProjectView = require './project_view'
template = require './templates/projects'

module.exports = class ProjectsView extends View
  template: template

  initialize: (options) ->
    @projects = options.projects

    @projects.on 'reset', @addAll, @
    @projects.on 'add', @addOne, @

    @projects.fetch()

  addAll: ->
    @projects.each(@addOne)

  addOne: (project) ->
    view = new ProjectView({model: project})
    @$('#project-list').append(view.render().el)
