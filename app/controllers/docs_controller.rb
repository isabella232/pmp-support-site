class DocsController < ApplicationController

  # GET /guides
  def users
    @markdowns = Dir.glob("#{Rails.root}/docs/users/*.md").sort()
    render :index
  end

  # GET /docs
  def developers
    @markdowns = Dir.glob("#{Rails.root}/docs/developers/*.md").sort()
    render :index
  end

  # GET /terms
  def terms_of_use
    @markdown = "#{Rails.root}/docs/misc/terms_of_use.md"
    render :show
  end

  # GET /service
  def service_level_agreement
    @markdown = "#{Rails.root}/docs/misc/service_level_agreement.md"
    render :show
  end

end
