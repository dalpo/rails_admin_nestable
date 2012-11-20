module RailsAdminNestable
  class Engine < ::Rails::Engine

    initializer "RailsAdminNestable precompile hook", group: :all do |app|
      app.config.assets.precompile += %w(rails_admin/rails_admin_nestable.js)
    end

  end
end
