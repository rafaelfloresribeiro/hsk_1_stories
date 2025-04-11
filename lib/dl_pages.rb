# frozen_string_literal_true
require 'open-uri'
require 'nokogiri'
require 'csv'

def print_list
  CSV.read('story_links.csv')
end

def write_list
  order = print_list
  order.map do |link|
    doc = Nokogiri::HTML(URI.open(link.join))
    content = doc.at_css('div.entry-content').text
    name = doc.at_css('h1').text
    File.write("#{name}.txt", content)
    sleep 5
    puts 'waitin 5s'
  end
end

write_list
