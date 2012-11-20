module RailsAdminNestable
  class Engine < ::Rails::Engine

    initializer "RailsAdminNestable precompile hook", group: :all do |app|
      app.config.assets.precompile += %w(jquery.nestable.js)
    end

  end
end
