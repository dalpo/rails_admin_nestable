module RailsAdminNestable
  class Engine < ::Rails::Engine

    initializer "RailsAdminNestable precompile hook", group: :all do |app|
      app.config.assets.precompile += %w(rails_admin/rails_admin_nestable.js rails_admin/jquery.nestable.js rails_admin/rails_admin_nestable.css)
    end

    initializer 'Include RailsAdminNestable::Helper' do |app|
      ActionView::Base.send :include, RailsAdminNestable::Helper
    end

  end
end
