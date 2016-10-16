require 'article_readingtime/version'

require 'nokogiri'

WORDS_PER_MINUTE = 275
IMAGE_MAX = 15
IMAGE_MIN = 3
IMAGE_STEP = 1

module ArticleReadingtime
  def self.estimate_html(html)
    doc = Nokogiri::HTML(html)
    count_text(doc) + count_images(doc)
  end

  def self.count_text(doc)
    words = doc.inner_text.split(' ')
    (words.length / WORDS_PER_MINUTE.to_f * 60).round
  end

  def self.count_images(doc)
    images_count = doc.css('img').length

    images_count.times.reduce(0) do |total, i|
      total + if IMAGE_MAX - i * IMAGE_STEP > IMAGE_MIN
                IMAGE_MAX - i
              else
                IMAGE_MIN
              end
    end
  end
end
