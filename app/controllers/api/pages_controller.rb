module Api
  class PagesController < ApplicationController
    respond_to :json
    before_filter :find_page, only: [:publish, :total_words]

    def index
      respond_with Page.all
    end

    def show
      respond_with Page.find(params[:id])
    end

    def create
      respond_with Page.create(params[:entry])
    end

    def update
      respond_with Page.update(params[:id], params[:entry])
    end

    def destroy
      respond_with Page.destroy(params[:id])
    end

    def published
      respond_with Page.published.desc
    end

    def unpublished
      respond_with Page.unpublished.desc
    end

    def publish
      @page.publish!
      respond_with({ status: :ok })
    end

    def total_words
      respond_with({ total_words: @page.total_words })
    end

    private 

    def find_page
      @page = Page.find(params[:id])
    end

  end
end
