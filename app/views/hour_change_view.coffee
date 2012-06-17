View = require './view'
template = require './templates/hour_change'

module.exports = class HourChangeView extends View
  template: template
  tagName: 'tr'
  className: 'hour-change'

  initialize: (options) ->
    @change = options.change

  getRenderData: ->
    {
      theDate: @change.date
      isIncrease: @change.hours > 0
      hours: Math.abs(@change.hours)
    }
