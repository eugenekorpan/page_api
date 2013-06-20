class PageApi.Views.EditPage extends Backbone.View
  template: JST['pages/edit']

  render: ->
    $(@el).html(@template(entry: @model))
    this

  attributes: ->
    {
      title: $(@el).find('input[name=title]').val(),
      content: $(@el).find('textarea[name=content]').val()
    }
