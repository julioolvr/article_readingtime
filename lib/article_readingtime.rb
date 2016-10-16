require "article_readingtime/version"

require 'nokogiri'

WORDS_PER_MINUTE = 275

module ArticleReadingtime
  def self.estimate_html(html)
    doc = Nokogiri::HTML(html)
    words = doc.inner_text.split(' ')
    (words.length / WORDS_PER_MINUTE.to_f * 60).round
  end
end
