# encoding: utf-8
require 'rubygems'
require 'nokogiri'
require 'open-uri'
require "iconv"

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

$ZHUBAJIE = "http://list.zhubajie.com/jianzhan/p-p{i}.html"

i=1
urls = []
100.times do
  urls << $ZHUBAJIE.gsub('{i}', i.to_s)
  i += 1
end

urls.each do |url|
  html = File.read(open(url))
  doc = Nokogiri::HTML(html)

  target_urls = []

  doc.css("p.nam > a").each do |h3|
    _url = h3["href"] + 'about'
    target_urls << _url unless target_urls.include?(_url)
  end

  target_urls.each do |url|
    page_doc = Nokogiri::HTML(open(url))
    puts url
    puts page_doc.css('meta')[2]
    puts "\n\n\n"
  end
end