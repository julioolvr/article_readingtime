require 'article_readingtime/version'

require 'nokogiri'

WORDS_PER_MINUTE = 275
IMAGE_MAX = 15
IMAGE_MIN = 3
IMAGE_STEP = 1

module ArticleReadingtime
  def self.estimate_html(html, options = {})
    wpm = options[:wpm] || WORDS_PER_MINUTE
    images_options = default_image_options(options[:images] || {})

    doc = Nokogiri::HTML(html)
    count_text(doc, wpm) + count_images(doc, images_options)
  end

  def self.default_image_options(options)
    {
      max: options[:max] || IMAGE_MAX,
      min: options[:min] || IMAGE_MIN,
      step: options[:step] || IMAGE_STEP
    }
  end

  def self.count_text(doc, wpm)
    words = doc.inner_text.split(' ')
    (words.length / wpm.to_f * 60).round
  end

  def self.count_images(doc, options)
    images_count = doc.css('img').length

    images_count.times.reduce(0) do |total, i|
      total + if options[:max] - i * options[:step] > options[:min]
                options[:max] - i * options[:step]
              else
                options[:min]
              end
    end
  end
end
