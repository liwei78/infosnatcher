require 'rubygems'
require 'nokogiri'
require 'open-uri'
require "iconv"

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

i=1
urls = []
200.times do
  urls << 'http://s.hc360.com/supply/%CD%F8%D5%BE%D6%C6%D7%F7.html?e='+i.to_s
  puts 'http://s.hc360.com/supply/%CD%F8%D5%BE%D6%C6%D7%F7.html?e='+i.to_s
  i += 24
end

def gtu(str)
  Iconv.new("UTF-8//IGNORE","GB2312//IGNORE").iconv(str)
end


titles = []
urls.each do |url|
  total = 0
  
  html = File.read(open(url))
  doc = Nokogiri::HTML(html)

  target_urls = []

  doc.css("h3 > a").each do |h3|
    href = h3["href"]
    target_urls << href unless target_urls.include?(href)
  end
  puts "target_urls: #{target_urls.count}"
  target_urls.each do |url|
    page_doc = Nokogiri::HTML(open(url))
    
    unless page_doc.css("li.product_saler_company")[0].nil?
      title = page_doc.css("li.product_saler_company")[0].content
      if titles.include?(title)
        break
      else
        titles << title
        total += 1
      end
    end
    
    page_doc.css("div.product_saler_info_list > ul > li").each do |c|
      content = c.content
      puts content
    end
  end
  
  puts "total: #{total}"
end

