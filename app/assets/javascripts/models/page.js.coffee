class PageApi.Models.Page extends Backbone.Model

  publish: ->
    $.ajax "/api/pages/#{@id}/publish", content_type: 'application/json', success: (response) =>
      @set({ 'published_on': response['published_on'] })
      @set({ 'status': 'published' })

  published: ->
    @get('status') == 'published'
