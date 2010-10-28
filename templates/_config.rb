require 'ostruct'

config_file = Rails.root+"config/app.yml"
options = YAML.load_file(config_file)
if !options[Rails.env]
  raise "'#{Rails.env}' was not found in #{config_file}"
end
AppConfig = OpenStruct.new(options[Rails.env])


SANITIZE_CONFIG = {
  :protocols =>  {
                  "a"=>{"href"=>["ftp", "http", "https", "mailto", :relative]},
                  "img"=>{"src"=>["http", "https", :relative]},
                  "blockquote"=>{"cite"=>["http", "https", :relative]},
                  "q"=>{"cite"=>["http", "https", :relative]}
                 },
  :elements  =>  ["a", "b", "blockquote", "br", "caption", "cite", "code", "col",
                  "colgroup", "dd", "dl", "dt", "em", "h1", "h2", "h3", "h4", "h5",
                  "h6", "i", "img", "li", "ol", "p", "pre", "q", "small", "strike",
                  "strong", "sub", "sup", "table", "tbody", "td", "tfoot", "th",
                  "thead", "tr", "u", "ul", "font", "s", "hr", "div", "span"],
  :attributes => {
                  "div" => ["style"],
                  "pre" => ["style"],
                  "code" => ["style"],
                  "colgroup"=>["span", "width"],
                  "col"=>["span", "width"],
                  "ul"=>["type"],
                  "a"=>["href", "title"],
                  "img"=>["align", "alt", "height", "src", "title", "width"],
                  "blockquote"=>["cite"],
                  "td"=>["abbr", "axis", "colspan", "rowspan", "width"],
                  "table"=>["summary", "width"],
                  "q"=>["cite"],
                  "ol"=>["start", "type"],
                  "th"=>["abbr", "axis", "colspan", "rowspan", "scope", "width"]
                 }
}


Rails.application.config.session_store :cookie_store, :key => AppConfig.session_key, :domain => :all
Rails.application.config.secret_token = AppConfig.session_secret

ActionMailer::Base.default_url_options[:host] = AppConfig.domain

if File.exist?(Rails.root + "VERSION")
  AppConfig.version = File.read(Rails.root + "VERSION")
end
