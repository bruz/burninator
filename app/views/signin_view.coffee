View = require './view'
template = require './templates/signin'

module.exports = class SigninView extends View
  template: template

  initialize: (options) ->
    @callback = options.complete

  afterRender: ->
    view = this
    @$('.modal').modal().on 'hide', (event) ->
      $(view.el).remove()
      view.callback()

  events:
    "click .signin" : "signin"

  signin: (event) ->
    event.preventDefault()

    username = @$('.username').val()
    password = @$('.password').val()

    view = this
    Parse.User.logIn username, password,
      success: (user) ->
        view.$('.modal').modal('hide')
        $(view.el).remove()
        view.callback(user)
      error: (user, error) ->
        view.$('.error').html(error.message)
