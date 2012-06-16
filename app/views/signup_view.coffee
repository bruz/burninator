View = require './view'
template = require './templates/signup'

module.exports = class SignupView extends View
  template: template

  initialize: (options) ->
    @callback = options.complete

  afterRender: ->
    view = this
    @$('.modal').modal().on 'hide', (event) ->
      $(view.el).remove()
      view.callback()

  events:
    "click .signup" : "signup"

  signup: (event) ->
    event.preventDefault()

    user = new Parse.User
      username: @$('.username').val()
      email: @$('.email').val()
      password: @$('.password').val()

    view = this
    user.signUp null,
      success: (user) ->
        view.$('.modal').modal('hide')
        $(view.el).remove()
        view.callback(user)
      error: (user, error) ->
        view.$('.error').html(error.message)
