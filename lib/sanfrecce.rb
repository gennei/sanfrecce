#require "sanfrecce/version"
require 'open-uri'
require 'nokogiri'
require 'pp'
module Sanfrecce
  module_function

  def players
    html = fetch_players
    players = Hash.new
    html.css('a').each do |item|
      no = item.css('span.uniform_number').text
      name = item.css('span.player_name > strong').text
      players[no] = name
    end
    return players
  end

  private

  def self.fetch_players
    # player url
    url = 'http://www.sanfrecce.co.jp/player/'
    html = Nokogiri::HTML(open(url), nil, 'CP932')
    players_html = html.css('#contents > div.stadium_bg > div > div.content_area.clearfix.player')
    return players_html
  end
end
