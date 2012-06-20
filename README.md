# Prospecto

*Simple rails presenter with an emphasis on just using ruby.*

## Installation

Add this line to your application's Gemfile:

    gem 'prospecto'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install prospecto

## Overview

There are 2 problems that prospecto was created to solve.

1. Views are hard and ineffective to test.
2. Code is often common between the output formats.

We feel that (our interpretation of) the presenter pattern is the answer to these problems. To be clear, you
do not need a library to implement the presenter pattern.  The purpose of prospecto is to provide some syntactic
sugar and structure.

## Usage

### ApplicationPresenter

To start it is recommended (but not required) that you generate an `ApplicationPresenter`.  This will act
as a base class for all other presenters much like an `ApplicationController`.  Just use the built in
generator:

    $ rails generate prospecto:install

### Presenter

You are now ready to start creating presenters.  In prospecto a presenter does not necessarily correlate with
a model (though this often ends up as the case), instead a presenter represents a view or family of views
depending on the situation.  This is up to you to decide.

To create a simple presenter use the included generator:

    $rails generate prospecto:presenter User

### Prospecto::PresenterView

By default all presenters inherit from the `Prospecto::PresenterView` class.  This class is optional and exists
solely to provide some sugar for creating constructors for objects.

#### accepts

The `accepts` method is the most encouraged.  It creates a private accessor for
the provided value.

``` ruby
class UserPresenter < Prospecto::PresenterView
  accepts :user

  def name
    "#{user.first} #{user.last}"
  end
end

view = UserPresenter.new(user: @user)
puts user.name
```

#### presents

The `presents` method is creates a public accessor for the provided value.  Use
of this is discouraged.

``` ruby
class UserPresenter < Prospecto::PresenterView
  presents :user_public
end

view = UserPresenter.new(user_public: @user)
puts "#{view.user_public.first} #{view.user_public.last}"
```

#### proxies

The `proxies` method creates named methods on the presenter for the provided value.

``` ruby
class UserPresenter < Prospecto::PresenterView
  proxies :user
end

view = UserPresenter.new(user: @user)
puts "#{view.user_first} #{view.user_last}"
```

### Rails Views and Controllers

How you use the presenters is very loose.  Since you are just dealing with pretty vanilla
ruby objects you can instantiate where it makes the most sense for your project.  Usually
basic usage looks something like this.

``` ruby
class UserController < ApplicationController
  def index
    users = User.where(active: true)
    @view = UserPresenter.new(users: users)
  end
end
```

You then use the `@view` object like normal in the view.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Sponsor

Development for prospecto is sponsored mainly by my employer [Voonami](http://www.voonami.com)
since we use it heavily in house.