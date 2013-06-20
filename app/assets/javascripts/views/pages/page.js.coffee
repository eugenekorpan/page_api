class PageApi.Views.Page extends Backbone.View
  template: JST['pages/page']

  tagName: 'tr'

  initialize: ->
    @model.on('change', @update, this)

  update: ->
    $(@el).html(@template(entry: @model))

  events:
    'click .edit': 'showEditPopup',
    'click .delete': 'delete',
    'click .publish': 'publish'

  render: ->
    $(@el).append(@template(entry: @model))
    this

  showEditPopup: ->
    editView = new PageApi.Views.EditPage(model: @model)
    console.log(editView.render())
    $('#dialog').html(editView.render().el)
    $('#dialog').dialog({ modal: true, })

  publish: ->
    @model.publish()

  delete: ->
    if confirm "Are you sure?"
      @model.destroy success: =>
        $(@el).remove()
