require 'rubygems'
require 'nokogiri'
require 'net/http'
require 'open-uri'
require "iconv"

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

urls = []
urls << 'http://search.china.alibaba.com/company/company_search.htm?showStyle=popular&keywords=%CD%F8%D5%BE%D6%C6%D7%F7&province=%C1%C9%C4%FE&pageSize=30&filt=y&n=y&beginPage=1'


titles = []
$target_urls = []


# require './henan'
require './henan'


def get_target_urls(target_urls)
  target_urls.each do |url|
    if url =~ /.html$/
      # _url = 'http://china.alibaba.com/company/detail/contact/'+url.gsub('http://china.alibaba.com/company/detail/', '')
      _url = url + '?fromSite=company_site&tab=companyWeb_contact'
      p ''
      page_doc = Nokogiri::HTML(open(_url))
      # p page_doc.css("meta")[2]['content']
      p page_doc.css("span.compay-name").text
      p page_doc.css("td.info")[1].text
    else
      # 2013.1.5 maybe not used
      _url = url + '/page/contactinfo.htm'
      p ''
      page_doc = Nokogiri::HTML(open(_url))
      # p page_doc.css("span.compay-name").content
      # p page_doc.css("td.info")[1].content
      p page_doc.css("meta")[2]['content']
    end

  end
end

urls.each do |url|
  uri = URI.parse(url)
  html = open(uri)
  # html = File.read(res)
  doc = Nokogiri::HTML(html)
  
  doc.css("div.offers > ul > li > h2 > a").each do |a|
    href = a['href']
    if href =~ /^http:\/\/page.china.alibaba.com/
      next
    else
      $target_urls << href unless $target_urls.include?(href)
    end
  end
  
  get_target_urls($target_urls)

end if false


get_target_urls($target_urls) if true
