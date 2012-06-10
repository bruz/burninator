View = require './view'
template = require './templates/project'

module.exports = class ProjectView extends View
  template: template
  tagName: 'li'

  getRenderData: ->
    {
      name: @model.get('name') 
    }
