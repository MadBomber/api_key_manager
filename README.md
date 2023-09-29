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

Now everytime `API.key` is called the ApiKeyManager::RateLimted` class complies with the rate limits.  When `delay:` is set to a TRUE value, if the limited count has already been reached then `API.key` will block until the limit period has been passed.

If you are accessing a rate limited API without a wrpaaer library - for example just using Faraday ...

```ruby
CONNECTION = Faraday.new(url: "https://example.com")
CONNECTION.get "/query?apikey=#{API.key}&q='xyzzy'"
CONNECTION.get "/query?apikey=#{API.key}&q='puff'"
```

If you are using some kind of bad (e.g. one that does not honor rate limitations) wrapper library around an API resource, you can reset that library's client configuration.

```ruby
config = BadWrapperLibrary.configuration
config.api_key = API.key
response = BadWrapperLibery.get_something
config.api_key = API.key
response = BadWrapperLibery.get_something_else
```

It that weird case you should create your own meta wrapper around the bad wrapper library.

Be a good developer; honor the rate limits.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/api_key_manager.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
