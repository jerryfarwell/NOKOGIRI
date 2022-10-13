require 'nokogiri'  
require 'open-uri'


def valdoise_email(valdoise_url)
    email = Nokogiri::HTML(URI.open(valdoise_url)).xpath('//main/section[2]//table/tbody/tr[4]/td[2]').text
    return email
end

def valdoise_urls(valdoise_url)

    array = [] 
    Nokogiri::HTML(URI.open(valdoise_url)).xpath("//a[@class='lientxt']/@href").each do |link|
        result = Hash.new
        result[link.text[5..-6].capitalize] = valdoise_email("http://annuaire-des-mairies.com#{link.text[1..-1]}")
        array << result
    end

    return array
    
end

def perform
    puts valdoise_urls("http://annuaire-des-mairies.com/val-d-oise.html")
end

perform
