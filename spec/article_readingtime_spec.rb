require 'spec_helper'

describe ArticleReadingtime do
  describe '.estimate_html' do
    it 'counts words at 275 wpm' do
      word_count = 275
      html = "<div>#{Array.new(word_count) { 'word' }.join(' ')}</div>"
      expect(ArticleReadingtime.estimate_html(html)).to equal 60
    end

    it 'counts the first image as 15 seconds' do
      html = '<img src="something.jpg"/>'
      expect(ArticleReadingtime.estimate_html(html)).to equal 15
    end

    it 'counts the following images one second less each' do
      html = <<-HTML
        <img src="something.jpg" />
        <img src="something2.jpg" />
        <img src="something3.jpg" />
      HTML

      expect(ArticleReadingtime.estimate_html(html)).to equal 15 + 14 + 13
    end

    it 'counts images as the fixed minimum once reached' do
      image_tag = '<img src="something.jpg" />'
      html = Array.new(15) { image_tag }.join('')
      expected_time = 15 + 14 + 13 + 12 + 11 + 10 + 9 + 8 + 7 + 6 + 5 + 4 + 3 + 3 + 3

      expect(ArticleReadingtime.estimate_html(html)).to equal expected_time
    end

    describe 'options' do
      it 'supports a custom WPM count' do
        word_count = 300
        html = "<div>#{Array.new(word_count) { 'word' }.join(' ')}</div>"
        expect(ArticleReadingtime.estimate_html(html, wpm: word_count)).to equal 60
      end

      it 'supports a custom maximum image time' do
        image_time = 20
        html = '<img src="something.jpg"/>'
        expect(ArticleReadingtime.estimate_html(html, images: { max: image_time })).to equal image_time
      end

      it 'supports a custom minimum image time' do
        image_time = 13
        html = '<img src="something.jpg"/>' * 5
        expect(ArticleReadingtime.estimate_html(html, images: { min: image_time })).to equal 15 + 14 + 13 + 13 + 13
      end

      it 'supports a custom step for image time' do
        image_step = 2
        html = '<img src="something.jpg"/>' * 3
        count = ArticleReadingtime.estimate_html(html, images: { step: image_step })
        expect(count).to equal 15 + 13 + 11
      end
    end
  end
end
