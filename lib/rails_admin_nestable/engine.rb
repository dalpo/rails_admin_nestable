module RailsAdminNestable
  class Engine < ::Rails::Engine

    initializer "RailsAdminNestable precompile hook", group: :all do |app|
      app.config.assets.precompile += %w(rails_admin/custom/ui.js rails_admin/custom/theming.scss)
    end

    initializer 'Include RailsAdminNestable::Helper' do |app|
      ActionView::Base.send :include, RailsAdminNestable::Helper
    end

  end
end
