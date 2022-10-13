require 'nokogiri'
require 'open-uri'

def method
  page = Nokogiri::HTML(URI.open('https://coinmarketcap.com/all/views/all/'))

  currencies = page.xpath('//*[@id="__next"]/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr[@class="cmc-table-row"]/td[2]/div/a[@class="cmc-table__column-name--name cmc-link"]')
  values = page.xpath('//*[@id="__next"]/div[1]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr[@class="cmc-table-row"]/td[5]/div/a/span')

  currenciesTab = [] 
  valuesTab = []

  currencies.each do |currencie|
    currenciesTab.push(currencie.text)
    end

  values.each do |value|
    valuesTab.push(value.text.delete("$,").to_f)
    end

  output=[]
  0...(currenciesTab.length).times do |i|
    h = Hash.new
    h[currenciesTab[i]] = valuesTab[i]
    output.push(h)
  end
return output
end

puts method