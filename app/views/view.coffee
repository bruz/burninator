require 'lib/view_helper'

# Base class for all views.
module.exports = class View extends Backbone.View
  template: ->
    return

  getRenderData: ->
    return

  render: =>
    # console.debug "Rendering #{@constructor.name}"
    @$el.html @template @getRenderData()
    @afterRender()
    this

  afterRender: ->
    return

  setupDatePickers: ->
    today = Date.today().toString('M/d/yyyy')
    @$('.date').attr('data-date', today)
    @$('.date input').val(today)
    @$('.date').datepicker()
