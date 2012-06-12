View = require './view'
template = require './templates/task'

module.exports = class Task extends View
  template: template
  tagName: 'tr'
  className: 'task'

  initialize: ->
    @model.on 'change:hours', @enableSave, @

    @savedHours = @model.completedHours()

  getRenderData: ->
    {
      name: @model.get('name')
      totalHours: @model.get('totalHours')
      completedHours: @model.completedHours()
    }

  afterRender: ->
    view = this
    start = @model.completedHours()

    @$('.slider').slider
      max: @model.get('totalHours')
      value: start
      slide: (event, ui) ->
        view.$('.completed-hours').text(ui.value)
      change: (event, ui) ->
        if start - ui.value == 0
          view.disableSave()
        else
          view.enableSave()

  events:
    "click .save" : "save"

  enableSave: ->
    @$('.save').removeClass('disabled')

  disableSave: ->
    @$('.save').addClass('disabled')

  save: (event) ->
    event.preventDefault()

    current = @$('.completed-hours').text()
    change = @savedHours - current 
    @model.changeHours(change)

    view = this
    @model.save
      success: ->
        view.disableSave()
        view.savedHours = current
