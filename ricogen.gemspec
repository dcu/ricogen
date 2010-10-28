require 'rubygems'
require 'rake'

HAML_GEMSPEC = Gem::Specification.new do |s|
  s.name = 'ricogen'
  s.rubyforge_project = 'ricogen'
  s.summary = "My rails 3 app generator based on hamgen"
  s.version = File.read('VERSION').strip
  s.authors = ['Hampton Catlin', "David Cuadrado"]
  s.email = 'krawek@gmail.com'
  s.description = <<-END
      A Rails 3.0 generator (like for the whole project) that pre-generates
      a bunch of shit I like. Most of it is stolen directly from Hampton's Rails Template
      at http://github.com/hcatlin/hamgen but with changes just for ole' me
    END

  s.add_runtime_dependency('colored', ['~> 1.2'])
  s.add_runtime_dependency('rails',   ['~> 3.0.0'])
  s.add_runtime_dependency('haml',    ['~> 3.0.18'])
  
  s.add_development_dependency('rake', ['~> 0.8.7'])

  s.executables = ['ricogen']
  s.files = Dir['**/**'].to_a.select { |f| f[0..2] != "pkg"}
  s.homepage = 'http://www.hamptoncatlin.com/'
end

