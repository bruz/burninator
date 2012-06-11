# Put your handlebars.js helpers here.
Handlebars.registerHelper 'textIf', (text, show) ->
  if show
    return text
  else
    return ''
