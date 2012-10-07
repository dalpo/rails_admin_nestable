# Rails Admin Nestable

Reorganise model data with a drag and drop tree/list structure.


## Installation

To enable rails_admin_nestable, add the following to your `Gemfile`:

```ruby
gem "rails_admin_nestable", git: "git://github.com/dalpo/rails_admin_nestable.git"
```

Add in your `config/initializers/rails_admin.rb` initializer the configuration:
```ruby
RailsAdmin.config do |config|
  config.actions do
    # root actions
    dashboard                     # mandatory
    # collection actions
    index                         # mandatory
    new
    export
    history_index
    bulk_delete
    # member actions
    show
    edit
    delete
    history_show
    show_in_app

    # Add the nestable action for each model
    nestable do
      visible do
        [NavNode, Product].include? bindings[:abstract_model].model
      end
    end
  end
end
```

## Configuration
You could choose between two different for your model:

### Nestable tree:
To use this configuration, you need to organize your tree model with [Ancestry](https://github.com/stefankroes/ancestry).
Otherwise your model have to respond to the `parent` and `arrange` methods.

Available options:
  * `position_field`: default `nil`, (optional)
  * `max_depth`: default `nil`, (optional)

In your `config/initializers/rails_admin.rb` initializer:
```ruby
RailsAdmin.config do |config|
  config.actions do
    ...
  end

  config.model MyModel do
    nestable_tree { position_field: :position, max_depth: 3 }
  end
end
```

### Nestable list:
To use this configuration, you need a position field

Available options:
  * `position_field`: default `:position`

In your `config/initializers/rails_admin.rb` initializer:
```ruby
RailsAdmin.config do |config|
  config.actions do
    ...
  end

  config.model MyModel do
    nestable_list
  end
end
```

## Thanks

* [Carlo Scortegagna](https://github.com/carloscortegagna)
* [Rails Admin](https://github.com/sferik/rails_admin)
* [Nestable](http://dbushell.github.com/Nestable)



This project rocks and uses MIT-LICENSE.
