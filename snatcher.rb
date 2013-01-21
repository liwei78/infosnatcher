require 'rubygems'
require 'hpricot'
require 'mechanize'
require 'open-uri'

agent = Mechanize.new
agent.user_agent_alias = 'Windows Mozilla'

agent.cookie_jar.load(File.join('.', 'cookies.txt'), format = :cookiestxt)
page = agent.get('http://china.alibaba.com/company/detail/hu0jincun.html?fromSite=company_site&tab=companyWeb_contact')

page.search('tr.content-info > td.info').each do |el|
	p el.text.gsub('/\n', '').gsub('/\t', '')
end

