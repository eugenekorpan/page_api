window.PageApi =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new PageApi.Routers.Pages()
    Backbone.history.start()

$(document).ready ->
  PageApi.init()
