Magent.setup(YAML.load_file(Rails.root.join('config', 'magent.yml')),
                  Rails.env, {})


MongoidExt.init

Dir.glob("#{RAILS_ROOT}/app/models/**/*.rb") do |model_path|
  File.basename(model_path, ".rb").classify.constantize
end

