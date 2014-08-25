class DocsController < ApplicationController

  # GET /docs
  def index
    @markdowns = Dir.glob("#{Rails.root}/docs/*.md").sort()
  end

end
