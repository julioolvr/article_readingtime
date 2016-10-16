# ArticleReadingtime

Given an HTML article, it calculates an estimated reading time for it. Similar to what [Medium does](https://help.medium.com/hc/en-us/articles/214991667-Read-time), although the exact behavior can be customized.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'article_readingtime'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install article_readingtime

## Usage

```ruby
require 'article_readingtime'

ArticleReadingtime.estimate_html <<HTML
  <article>
    <p>
      Lorem ipsum dolor sit amet, consectetur adipiscing elit,
      sed do eiusmod tempor incididun
    </p>
  </article>
HTML

#=> 3
```

`ArticleReadingtime.estimate_html` receives an HTML string and returns an estimate of the time in seconds it takes to read it. By default, it considers an average of 275 WPM. The first image is counted as 12 seconds, the second one as 11 seconds, and it keeps decreasing down to 3 seconds for each image. A second optional parameter can be used to customize these values:

```ruby
ArticleReadingtime.estimate_html <<HTML, wpm: 300
  <article>
    <!-- ... -->
  </article>
HTML
```

Image time calculation can be customized by changing the maximum, minimum and step. For instance, for the first image to be counted as 15 seconds, down until 5 seconds, and reduce 2 seconds for each new image, the options would look like:

```ruby
ArticleReadingtime.estimate_html <<HTML, images: { max: 15, min: 5, step: 2 }
  <article>
    <!-- ... -->
  </article>
HTML
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/julioolvr/article_readingtime.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
