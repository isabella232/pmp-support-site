require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'

# actionview handler for markdown-to-html
module MarkdownHandler

  # redcarpet configuration
  MARKDOWN_EXT = {
    no_intra_emphasis: true,
    tables: true,
    fenced_code_blocks: true,
    autolink: true,
    disable_indented_code_blocks: true,
    # strikethrough:
    # lax_spacing:
    # space_after_headers:
    # superscript:
    # underline:
    highlight: true,
    # quote:
    # footnotes:
  }
  RENDER_EXT = {
    # filter_html:
    # no_images:
    # no_links:
    # no_styles:
    # escape_html:
    # safe_links_only:
    with_toc_data: true,
    # hard_wrap:
    # xhtml:
    prettify: true,
    # link_attributes:
  }

  # custom renderer
  class HtmlRenderer < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
    include Redcarpet::Render::SmartyPants

    # anchor h1's and h2's
    def header(text, level)
      id = text.downcase.gsub(/( +|\.+)/, '-').gsub(/[^a-zA-Z0-9\-_]/, '')
      if level == 1
        @last_h1 = id
        fixed_navbar_fix = "<div class='hdr-anchor' id='#{id}'></div>"
        "#{fixed_navbar_fix}<h#{level} id='#{id}'>#{text}</h#{level}>"
      elsif level == 2
        id = "#{@last_h1 || ''}-#{id}"
        fixed_navbar_fix = "<div class='hdr-anchor' id='#{id}'></div>"
        "#{fixed_navbar_fix}<h#{level} id='#{id}'>#{text}</h#{level}>"
      else
        "<h#{level}>#{text}</h#{level}>"
      end
    end
  end

  # allow erb
  def self.erb
    @erb ||= ActionView::Template.registered_template_handler(:erb)
  end

  # compile any erb before rendering
  def self.call(template)
    @renderer ||= HtmlRenderer.new(RENDER_EXT)
    @markdown ||= Redcarpet::Markdown.new(@renderer, MARKDOWN_EXT)
    # compiled_source = erb.call(template) TODO: this is being weird
    "#{@markdown.render(template.source).inspect}.html_safe"
  end

end

ActionView::Template.register_template_handler :md, MarkdownHandler
