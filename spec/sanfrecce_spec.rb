require 'spec_helper'
require 'sanfrecce'

describe Sanfrecce do
  context :players do
    it 'players' do
      begin
        actual = Sanfrecce.players
        expect(actual.empty?).to eq(false)
      end
    end

    it 'number' do
      begin
        actual = Sanfrecce.players['11']
        expect(actual).to eq('佐藤　寿人')
      end
    end
  end

  context :games do
    it 'games' do
      begin
        actual = Sanfrecce.all_games
        expect(actual.empty?).to eq(false)
      end
    end

    it 'game' do
      begin
        actual = Sanfrecce.first_stage['1st-1']
        expect(actual[:team]).to eq('ヴァンフォーレ甲府')
      end
    end
  end

  context ':ranking' do
    it 'ranking' do
      actual = Sanfrecce.ranking
      expect(actual.empty?).to eq(false)
    end

    it 'first_ranking' do
      actual = Sanfrecce.first_ranking
      expect(actual.empty?).to eq(false)
    end

    it 'second_ranking' do
      actual = Sanfrecce.second_ranking
      expect(actual.empty?).to eq(true)
    end
  end
end
