# frozen_string_literal_true
require 'open-uri'
require 'nokogiri'
require 'csv'
require 'net/http'
require 'pry-byebug'

def print_list
  CSV.read('story_links.csv')
end

def write_list
  order = print_list
  order.map do |link|
    html = Net::HTTP.get(URI(link.join))
    doc = Nokogiri::HTML(html)
    content = doc.at_css('div.entry-content').text
    name = doc.at_css('h1').text
    puts name, content
    File.write("../stories/#{name}.txt", content)
    puts 'waitin 5s'
    sleep 5
  end
end

puts write_list
