View = require './view'
Projects = require 'collections/projects'
ProjectView = require './project_view'
template = require './templates/projects'

module.exports = class ProjectsView extends View
  template: template

  initialize: ->
    @projects = new Projects()

    @projects.on 'reset', @addAll, @

    @projects.fetch()

  addAll: ->
    @projects.each(@addOne)

  addOne: (project) ->
    view = new ProjectView({model: project})
    @$('#project-list').append(view.render().el)
