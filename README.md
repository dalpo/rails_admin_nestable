# Rails Admin Nestable

RailsAdmin Drag and drop tree view for `Ancestry` and `mongoid-ancestry` gem

Sample demo available at: https://github.com/dalpo/rails_admin_nestable_demo

[![Gem Version](https://badge.fury.io/rb/rails_admin_nestable.png)](http://badge.fury.io/rb/rails_admin_nestable)
[![Code Climate](https://codeclimate.com/github/dalpo/rails_admin_nestable.png)](https://codeclimate.com/github/dalpo/rails_admin_nestable)

## Installation

To enable rails_admin_nestable, add the following to your `Gemfile`:

```ruby
gem 'rails_admin_nestable', '~> 0.3.2'
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
To use this configuration, you need to organize your tree model with [Ancestry](https://github.com/stefankroes/ancestry) or [Mongoid Ancestry](https://github.com/skyeagle/mongoid-ancestry).
Otherwise your model have to respond to the `parent`, `arrange` and `children` methods.

The `nestable_tree` methods supports the following options:
  * `position_field`: (symbol) default => `nil`
  * `max_depth`: (integer) default => `nil`
  * `enable_callback`: (boolean) default => `false`
  * `scope`: (symbol | proc) default => `nil`
  * `live_update`: (boolean | :only) default => true (:only is for live updating only)

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
  * `scope`: (symbol | proc) default => `nil`
  * `live_update`: (boolean | :only) default => true (:only is for live updating only)

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


## Contributing
Submitting a Pull Request:

1. [Fork the repository.][fork]
2. [Create a topic branch.][branch]
3. Implement your feature or bug fix.
4. Add, commit, and push your changes.
5. [Submit a pull request.][pr]

[fork]: http://help.github.com/fork-a-repo/
[branch]: http://learn.github.com/p/branching.html
[pr]: http://help.github.com/send-pull-requests/


## Thanks

* [Carlo Scortegagna](https://github.com/carloscortegagna)
* [Andrea Zaupa](https://github.com/andreazaupa)
* [Rails Admin](https://github.com/sferik/rails_admin)
* [Nestable](http://dbushell.github.com/Nestable)
* [To see the generous people who have contributed code, take a look at the contributors page](https://github.com/dalpo/rails_admin_nestable/graphs/contributors)

## License
**This project rocks and uses MIT-LICENSE.**

Copyright 2015 Andrea Dal Ponte

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
