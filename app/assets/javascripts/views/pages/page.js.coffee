class PageApi.Views.Page extends Backbone.View
  template: JST['pages/page']

  tagName: 'tr'

  initialize: ->
    @model.on('change', @update, this)

  update: ->
    $(@el).html(@template(entry: @model, admin: window.admin))

  events:
    'click .edit': 'showEditPopup',
    'click .delete': 'delete',
    'click .publish': 'publish',
    'click .title': 'showPage'


  render: ->
    $(@el).append(@template({entry: @model, admin: window.admin}))
    this

  showEditPopup: ->
    _model = @model
    editView = new PageApi.Views.EditPage(model: _model)
    $('#dialog').html(editView.render().el)
    $('#dialog').dialog
      modal: true,
      title: 'Edit page',
      buttons:
        'Save': ->
          _model.set(editView.attributes())
          _model.save()
          collection = new PageApi.Collections.Pages()
          collection.fetch success: =>
            new PageApi.Views.PagesIndex(collection: collection)
          $(this).dialog "close",
        'Cancel': ->
          $(this).dialog( "close" )

  publish: ->
    @model.publish()

  delete: ->
    if confirm "Are you sure?"
      @model.destroy success: =>
        $(@el).remove()

  showPage: ->
    showView = new PageApi.Views.ShowPage(model: @model)
    $('#dialog').html(showView.render().el)
    $('#dialog').dialog
      modal: true,
      title: 'Page Details',
      buttons:
        'Ok': ->
          $(this).dialog "close"
