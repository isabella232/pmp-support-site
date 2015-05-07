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

end
