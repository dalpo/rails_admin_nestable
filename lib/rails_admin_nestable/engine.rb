module RailsAdminNestable
  class Engine < ::Rails::Engine

    # Enabling assets precompiling
    initializer :assets do |config|
      Rails.application.config.assets.precompile += %w( jquery.nestable.js )
    end

  end
end
