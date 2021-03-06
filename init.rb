

# REQUIRED GEMS
require "colored"
require "rails"
require "haml"
require "bundler"

@path = "#{File.dirname(__FILE__)}/templates/"

# START THIS THING
puts  "\n========================================================="
puts  " HAMPTON'S SHAWN'S RAILS 3 TEMPLATE - [#{File.read(@path + '../VERSION').strip}] ".yellow.bold
puts  "=========================================================\n\n"

# REMOVE FILES
puts  "---------------------------------------------------------"
puts  " Removing useless junk ... ".red
puts  "---------------------------------------------------------"
run   "rm README"
run   "rm public/index.html"
run   "rm public/favicon.ico"
run   "rm public/robots.txt"
run   "rm -r public/images"
run   "rm -f public/javascripts/*"
run   "rm app/views/layouts/application.html.erb"
run   "rm config/initializers/session_store.rb"
run   "rm config/initializers/secret_token.rb"
puts  "---------------------------------------------------------"

# ADD FILES
puts  " Adding useful junk ... ".green
puts  "---------------------------------------------------------"
run   "cp #{@path}application.html.haml app/views/layouts"
run   "mkdir public/images"
run   "mkdir public/images/backgrounds"
run   "mkdir public/images/sprites"
puts  "---------------------------------------------------------"

# GIT INIT
puts  " Initializing new Git repo ...".cyan
puts  "---------------------------------------------------------"
run   "rm .gitignore"
run   "touch .gitignore"
run   "cat #{@path}gitignore >> .gitignore"
git   :init
git   :add => "."
puts  "---------------------------------------------------------"

# JAVASCRIPT
puts  " Adding Javascript files ...".green
puts  "---------------------------------------------------------"
run   "cp #{@path}javascripts/application.js public/javascripts"
run   "cp #{@path}javascripts/rails.js public/javascripts"
puts  "---------------------------------------------------------"

# SASS
puts  " Installing Sass directory, files and environment preferences ...".green
puts  "---------------------------------------------------------"
run   "cp -r #{@path}sass app/stylesheets"
run   "cp #{@path}compass.rb config/initializers/"
run   "cp #{@path}compass.config config/"
run   "cat #{@path}environment.rb >> config/environment.rb"
# Dir["app/sass/**/*.sass"].each do |file|
#   run "sass-convert -T sass -F sass -i #{file}"
# end
puts  "---------------------------------------------------------"

# SASS
puts  " Installing Mongodb dependencies, files and environment preferences ...".green
puts  "---------------------------------------------------------"
run   "cp #{@path}_config.rb config/initializers/"
run   "cp #{@path}mongo.rb config/initializers/"
run   "cp #{@path}mongoid.yml config/"
run   "cp #{@path}magent.yml config/"
run   "cp #{@path}auth_providers.yml config/"

default_config = {"session_secret" => ActiveSupport::SecureRandom.hex(80),
                  "session_key" => "__app_session",
                  "domain" => "localhost"}

File.open("config/app.yml", "w") do |f|
  f.puts({"development" => default_config}.to_yaml)
end

data = File.read("#{@path}application.rb")
orig_data = File.read("config/application.rb")

File.open("config/application.rb", "w") do |f|
  orig_data.each_line do |line|
    if line =~ /^require 'rails\/all'/
      f.puts %@require "action_controller/railtie"
require "action_mailer/railtie"
require "active_resource/railtie"\n@
    elsif line =~ /^\s+config\.filter_parameters/
      f.write(line)
      f.puts(data)
    else
      f.write(line)
    end
  end
end

puts  "---------------------------------------------------------"

# GEMFILE
puts  " Appending Gemfile and running Bundler ...".magenta
puts  "---------------------------------------------------------"
run   "cat #{@path}Gemfile > Gemfile"
puts  "         Running Bundler install. This could take a moment ...".yellow
run   "bundle install"
puts  "         Bundled gems installed successfully!".green.bold
puts  "---------------------------------------------------------"

# GIT COMMIT
puts  " Creating initial Git commit ...".cyan
puts  "---------------------------------------------------------"
git   :add => "."
git   :commit => "-am 'Initial commit.'"

# DONE!
puts  "\n========================================================="
puts  " INSTALLATION COMPLETE!".yellow.bold
puts  "=========================================================\n\n\n"
