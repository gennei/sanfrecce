require 'open-uri'
require 'nokogiri'

# sanfrecce
module Sanfrecce
  module_function

  def players
    html = fetch_players
    players = {}
    html.css('a').each do |item|
      no = item.css('span.uniform_number').text
      name = item.css('span.player_name > strong').text
      players[no] = name
    end
    players
  end

  def first_stage
    games = {}
    fetch_games.css('div:nth-child(3) > table > tr').each do |item|
      games['1st-' + item.css('td:nth-child(1)').text] = game_detail(item)
    end
    games.delete_if { |key, _value| key == '1st-' }
  end

  def second_stage
    games = {}
    fetch_games.css('div:nth-child(4) > table > tr').each do |item|
      games['2nd-' + item.css('td:nth-child(1)').text] = game_detail(item)
    end
    games.delete_if { |key, _value| key == '2nd-' }
  end

  def all_games
    first_stage.merge(second_stage)
  end

  private

  def self.fetch_players
    # player url
    url = 'http://www.sanfrecce.co.jp/player/'
    html = Nokogiri::HTML(open(url), nil, 'CP932')
    players_html = html.css('#contents > div.stadium_bg > div > div.content_area.clearfix.player')
    players_html
  end

  def self.fetch_games
    url = 'http://www.sanfrecce.co.jp/info/game_schedule/'
    html = Nokogiri::HTML(open(url), nil, 'CP932')
    games_html = html.css('#contents > div.stadium_bg > div > div.content_area.clearfix > div.content_area_left.float_l')
    games_html
  end

  def self.game_detail(item)
    {
      'Day': item.css('td:nth-child(2)').text,
      'Kickoff': item.css('td:nth-child(3)').text,
      'team': item.css('td:nth-child(4)').text,
      'result': item.css('td:nth-child(5)').text,
      'stadium': item.css('td:nth-child(6)').text
    }
  end
end
