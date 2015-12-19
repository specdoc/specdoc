# Specdoc

Specdoc -> API Blueprint -> Tooling

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'specdoc'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install specdoc

## Usage


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/specdoc/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Thanks & Credits

This gem was inspired by rspec-api-blueprint by @calderalabs, and this codebase was bootstrapped off that gem, and one of its most popular forks from  @officespacesoftware

The initial reasons for starting a new project are the following:

The official repo hasn't been updated in 2 years, and there are many disparate forks, so
it would be nice to have a repository and a new name that won't point people to outdated code.

The method of defining the API documentation relies on string parsing, we will offer a more explicit way to define the API blueprint, including more advanced features such as parameter options.

Specdoc also takes a different approach to rspec integration, using tags to cleanly separate specdoc specs from other specs.

Finally, we hope to have the project itself tested, and great documentation including the example project.

# Ideas and future direction
- Generate the Blueprint API Json format instead of the markdown format?
-
