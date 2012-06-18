application = require 'application'

$ ->
  # Parse.com account - substitute your account credentials here
  Parse.initialize("rRUG9Y1Q3H0mJxasSpa3LwBemfMfJbPnQ2x33MGv", "Po5ZWBMXhuN4q6eLrUSZwRk725cO9A5SOkLICF9q")

  # start the backbone.js app
  application.initialize({pushState: true})

  # route the initial URL when the page loads
  Backbone.history.start()
