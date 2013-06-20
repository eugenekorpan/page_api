class PageApi.Routers.Pages extends Backbone.Router
  routes:
    '': 'index'

  index: ->
    if $('#container').size() == 1
      @collection = new PageApi.Collections.Pages()
      @collection.fetch({success: @renderIndex})

  renderIndex: =>
    new PageApi.Views.PagesIndex(collection: @collection)
