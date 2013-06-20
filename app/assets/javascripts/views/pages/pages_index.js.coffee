class PageApi.Views.PagesIndex extends Backbone.View

  template: JST['pages/index']

  events:
    'click #refresh_unpublished' : 'showUnpublished',
    'click #refresh_published' : 'showPublished',
    'click #refresh' : 'refresh',
    'click #new_page' : 'showNewPageForm'

  filterByPublishedStatus: (url) =>
    collection = new PageApi.Collections.Pages()
    collection.fetch url: url, success: =>
      new PageApi.Views.PagesIndex(collection: collection)

  showUnpublished: =>
    @filterByPublishedStatus('/api/pages/unpublished')

  showPublished: ->
    @filterByPublishedStatus('/api/pages/published')

  refresh: =>
    @filterByPublishedStatus('/api/pages')

  showNewPageForm: =>
    _this = @
    model = new PageApi.Models.Page()
    view = new PageApi.Views.EditPage(model: model)
    $('#dialog').html(view.render().el)
    $('#dialog').dialog
      modal: true,
      title: 'Create new page',
      buttons:
        'Save': ->
          collection = new PageApi.Collections.Pages()
          collection.create({ page: view.attributes() })
          _this.refresh()
          $(this).dialog "close",
        'Cancel': ->
          $(this).dialog("close")

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
