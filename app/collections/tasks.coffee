Collection = require './collection'
Task = require 'models/task'

module.exports = class Tasks extends Collection
  model: Task

  # make tasks sort by name
  comparator: (task) ->
    task.get('name')
