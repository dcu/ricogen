    config.generators do |g|
      g.orm = :mongoid
      g.template_engine = :haml
      g.test_framework = :rspec
    end

    config.middleware.use "MongoidExt::FileServer"

