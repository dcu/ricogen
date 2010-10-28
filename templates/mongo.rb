MongoMapper.setup(YAML.load_file(Rails.root.join('config', 'database.yml')),
                  Rails.env, { :logger => Rails.logger, :passenger => false })

Magent.setup(YAML.load_file(Rails.root.join('config', 'magent.yml')),
                  Rails.env, {})


MongoMapperExt.init

Dir.glob("#{RAILS_ROOT}/app/models/**/*.rb") do |model_path|
  File.basename(model_path, ".rb").classify.constantize
end

# HACK: do not create indexes on every request
module MongoMapper::Plugins::Indexes::ClassMethods
  def ensure_index(*args)
  end
end
