application = require 'application'

$ ->
  Parse.initialize("rRUG9Y1Q3H0mJxasSpa3LwBemfMfJbPnQ2x33MGv", "Po5ZWBMXhuN4q6eLrUSZwRk725cO9A5SOkLICF9q")
  application.initialize()
  Backbone.history.start()
