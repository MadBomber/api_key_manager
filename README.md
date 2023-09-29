# ApiKeyManager

Manage one or more API keys to the same resource that are rate limited.

## Installation

Install the gem and add to the application's Gemfile by executing:

    bundle add api_key_manager

If bundler is not being used to manage dependencies, install the gem by executing:

    gem install api_key_manager

## Usage

```ruby
API = ApiKeyManager::RateLimited.new(
            api_keys:    ENV['API_KEYS'],
            delay:       ENV['API_RATE_DELAY'],
            rate_count:  EMV['API_RATE_COUNT'],
            rate_period: ENV['API_RATE_PERIOD']
        )
#
API.key
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/api_key_manager.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).