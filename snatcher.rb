require 'rubygems'
require 'hpricot'
require 'mechanize'
require 'open-uri'

$target_urls = []

require './henan'

$agent = Mechanize.new
$agent.user_agent_alias = 'Windows Mozilla'

$agent.cookie_jar.load(File.join('.', 'cookies.txt'), format = :cookiestxt)
# page = agent.get('http://china.alibaba.com/company/detail/hu0jincun.html?fromSite=company_site&tab=companyWeb_contact')

def get_target_urls(target_urls)
  target_urls.each do |url|
    if url =~ /.html$/
      _url = url + '?fromSite=company_site&tab=companyWeb_contact'
      page = $agent.get(_url)
      p (page/"title").text
      p (page/"div.content")[1].text.gsub(' ', '').gsub(/(\t|\n)/, '')
    else
      _url = url + '/page/contactinfo.htm'
      page = $agent.get(_url)
      p (page/"title").text
      p (page/"dl.m-mobilephone > dt").text
      p (page/"dl.m-mobilephone > dd").text.gsub(' ', '')
    end
    p '_'*100
  end
end

# page.search('tr.content-info > td.info').each do |el|
# 	p el.text.gsub('/\n', '').gsub('/\t', '')
# end

1.times do
	$target_urls << 'http://dingirl.cn.alibaba.com/'
	$target_urls << 'http://china.alibaba.com/company/detail/hjx15225131631.html'
end if false

get_target_urls($target_urls)
