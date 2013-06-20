module Api
  class PagesController < ApplicationController
    respond_to :json
    before_filter :find_page, only: [:publish, :total_words]

    def index
      pages = current_user.admin? ? Page.desc : current_user.pages.desc
      respond_with pages
    end

    def show
      respond_with Page.find(params[:id])
    end

    def create
      respond_with current_user.pages.create(params[:page]), location: api_pages_url
    end

    def update
      respond_with Page.update(params[:id], params[:page])
    end

    def destroy
      Page.destroy(params[:id])
      respond_with({ status: :ok })
    end

    def published
      respond_with current_user.pages.published.desc
    end

    def unpublished
      respond_with current_user.pages.unpublished.desc
    end

    def publish
      @page.publish!
      respond_with({ status: :ok, published_on: @page.published_on })
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
