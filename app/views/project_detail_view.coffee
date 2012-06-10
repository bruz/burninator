View = require './view'
template = require './templates/project_detail'

module.exports = class ProjectView extends View
  template: template

  getRenderData: ->
    {
      name: @model.get('name') 
    }
