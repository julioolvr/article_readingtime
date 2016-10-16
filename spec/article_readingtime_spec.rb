require 'spec_helper'

describe ArticleReadingtime do
  describe '.estimate_html' do
    it 'counts words at 275 wpm' do
      word_count = 275
      html = "<div>#{word_count.times.map { 'word' }.join(' ')}</div>"
      expect(ArticleReadingtime.estimate_html(html)).to equal 60
    end
  end
end
