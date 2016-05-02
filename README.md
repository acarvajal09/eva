# Eva

<p align="center">
<img src="https://github.com/acarvajal09/eva/blob/master/assets/eva.png" alt="Eva"/>
<br>
<img src="https://travis-ci.org/acarvajal09/eva.svg?branch=master" alt="travis-status"/>
</p>

Toy robot simulator

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'eva'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install eva

## Usage

First cd to project

- Automatic
    - `bundle install`
    - `bin/setup`
    - `bin/console`
    - `Eva::Cli.start`

- Manual
    - `bundle install`
    - `gem build eva.gemspec`
    - `gem install eva-0.1.0.gem`
    - `irb`
    - `require 'eva'`
    - `Eva::Cli.start`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/acarvajal09/eva. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

