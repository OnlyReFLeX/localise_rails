# LocaliseRails

Easy localise for your Rails app from localise.biz (I18n)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'localise_rails'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install localise_rails

## Usage

### Configuration
```ruby
# config/initializers/localise_rails.rb
LocaliseRails.configure do |config|
  config.api_key = "LOCALISE_KEY"

  ### all options https://localise.biz/api/docs/export/exportall
  # config.options = {
  #   filter: 'backend',
  #   fallback: 'en-US'
  # }

  ### rename locales from localise
  # config.rename_locales = {
  #   'en-US' => 'en'
  # }
  
  ### set prefix for locales
  # config.prefix = 'localise'
  
  ### all options https://github.com/redis/redis-rb
  # config.redis_options = {
  #   host: "127.0.0.1", 
  #   port: 6379, 
  #   db: 1,
  #   url: "redis://:p4ssw0rd@127.0.0.1:6379/1"
  # }
end
```
### How to update locales
To crontab
```ruby
LocaliseRails.update
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/OnlyReFLeX/localise_rails.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
