class PageApi.Views.PagesIndex extends Backbone.View

  template: JST['pages/index']

  initialize: ->
    @render()

  render: ->
    $(@el).html(@template())
    $('#container').html(@el)
    @collection.each(@appendPage)
    this

  appendPage: (page) =>
    view = new PageApi.Views.Page(model: page)
    $('#pages').append(view.render().el)
