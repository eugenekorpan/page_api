class PageApi.Views.ShowPage extends Backbone.View
  template: JST['pages/show']

  render: ->
    $(@el).html(@template(entry: @model))
    this
