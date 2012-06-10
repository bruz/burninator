Collection = require './collection'
Task = require 'models/task'

module.exports = class Tasks extends Collection
  model: Task
