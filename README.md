# Rails Admin Nestable

Reorganise model data with a drag and drop tree/list structure.

Sample demo available at: https://github.com/dalpo/rails_admin_nestable_demo


## Installation

To enable rails_admin_nestable, add the following to your `Gemfile`:

```ruby
gem 'rails_admin_nestable'
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

    # Add the nestable action for configured models
    nestable
  end
end
```

## Configuration
You could choose between two different configurations for your model:

### 1. Nestable tree:
To use this configuration, you need to organize your tree model with [Ancestry](https://github.com/stefankroes/ancestry).
Otherwise your model have to respond to the `parent`, `arrange` and `children` methods.

The `nestable_tree` methods supports the following options:
  * `position_field`: (symbol) default => `nil`
  * `max_depth`: (integer) default => `nil`
  * `enable_callback`: (boolean) default => `false`

In your `config/initializers/rails_admin.rb` initializer:
```ruby
RailsAdmin.config do |config|
  config.actions do
    ...
  end

  config.model MyModel do
    nestable_tree({
      position_field: :position,
      max_depth: 3
    })
  end
end
```


### 2. Nestable list:
To use this configuration, you need a position field

The `nestable_list` methods supports the following options:
  * `position_field`: (symbol) default `:position`
  * `enable_callback`: (boolean) default => `false`
  * `scope`: (symbol|proc) default `nil`, must be a `ActiveRecord::Relation` object of models

In your `config/initializers/rails_admin.rb` initializer:
```ruby
RailsAdmin.config do |config|
  config.actions do
    ...
  end

  config.model MyModel do
    nestable_list true
  end
end
```

## Authorization with [CanCan](https://github.com/ryanb/cancan)

Sample ability:
```ruby
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :access, :rails_admin
      can :dashboard

      if user.role? :superadmin
        can :manage, :all
      end

      if user.role? :editor
        can :edit, :all
        can :nestable, :all
      end
    end
  end
end

```


## Screenshot

![Nestable view](https://github.com/dalpo/rails_admin_nestable/raw/master/screenshots/nestable_tree.jpg "nestable view")

## Thanks

* [Carlo Scortegagna](https://github.com/carloscortegagna)
* [Andrea Zaupa](https://github.com/andreazaupa)
* [Rails Admin](https://github.com/sferik/rails_admin)
* [Nestable](http://dbushell.github.com/Nestable)



**This project rocks and uses MIT-LICENSE.**
