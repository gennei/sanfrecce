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
      name = html2text(item, 'span.player_name > strong')
      players[no] = name
    end
    players
  end

  def first_stage
    games = {}
    fetch_games.css('div:nth-child(4) > table > tr').each do |item|
      games['1st-' + html2text(item, 'td:nth-child(1)')] = game_detail(item)
    end
    games.delete_if { |key, _value| key == '1st-' }
  end

  def second_stage
    games = {}
    fetch_games.css('div:nth-child(3) > table > tr').each do |item|
      games['2nd-' + html2text(item, 'td:nth-child(1)')] = game_detail(item)
    end
    games.delete_if { |key, _value| key == '2nd-' }
  end

  def all_games
    first_stage.merge(second_stage)
  end

  def ranking
    rank = {}
    fetch_ranking.css('div:nth-child(5) > table > tr').each do |item|
      rank[html2text(item, 'td:nth-child(1)')] = rank_detail(item)
    end
    rank.delete_if { |key, _value| key == '' }
  end

  def first_ranking
    rank = {}
    fetch_ranking.css('div:nth-child(3) > table > tr').each do |item|
      rank[html2text(item, 'td:nth-child(1)')] = rank_detail(item)
    end
    rank.delete_if { |key, _value| key == '' }
  end

  def second_ranking
    rank = {}
    fetch_ranking.css('div:nth-child(4) > table > tr').each do |item|
      rank[html2text(item, 'td:nth-child(1)')] = rank_detail(item)
    end
    rank.delete_if { |key, _value| key == '' }
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

  def self.fetch_ranking
    url = 'http://www.sanfrecce.co.jp/info/ranking/'
    html = Nokogiri::HTML(open(url), nil, 'CP932')
    games_html = html.css('#contents > div.stadium_bg > div > div.content_area.clearfix')
    games_html
  end

  def self.game_detail(item)
    {
      'Day': html2text(item, 'td:nth-child(2)'),
      'Kickoff': html2text(item, 'td:nth-child(3)'),
      'team': html2text(item, 'td:nth-child(4)'),
      'result': html2text(item, 'td:nth-child(5)'),
      'stadium': html2text(item, 'td:nth-child(6)')
    }
  end

  def self.rank_detail(item)
    {
      'team': html2text(item, 'td:nth-child(2)'),
      'points': html2text(item, 'td:nth-child(3)'),
      'played': html2text(item, 'td:nth-child(4)'),
      'win': html2text(item, 'td:nth-child(5)'),
      'draw': html2text(item, 'td:nth-child(6)'),
      'lose': html2text(item, 'td:nth-child(7)'),
      'goal': html2text(item, 'td:nth-child(8)'),
      'lost': html2text(item, 'td:nth-child(9)'),
      'diff': html2text(item, 'td:nth-child(10)')
    }
  end

  def self.html2text(item, tag)
    item.css(tag).text
  end
end
