    config.generators do |g|
      g.orm = :mongo_mapper
      g.template_engine = :haml
      g.test_framework = :rspec
    end

    config.middleware.use "MongoMapperExt::FileServer"

