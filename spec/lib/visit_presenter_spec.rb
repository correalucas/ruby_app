# frozen_string_literal: true

require_relative '../../lib/visit_presenter'

RSpec.describe VisitPresenter do
  let(:visit_collection) do
    visit_collection = VisitCollection.new
    visit_collection.add('kling.info', 'bruce.klocko@reichert.net')
    visit_collection.add('kling.info', 'bruce.klocko@reichert.net')
    visit_collection.add('lueilwitz.info', 'wiley_weimann@hessel.io')
    visit_collection.add('lueilwitz.info', 'bruce.klocko@reichert.net')
    visit_collection.add('kling.info', 'bruce.klocko@reichert.net')
    visit_collection.add('marks.net', 'brittaney@strosin.info')
  end

  subject { VisitPresenter.new(visit_collection) }

  describe '.initialize' do
    it do
      expect { VisitPresenter.new }.to raise_error(
        ArgumentError, 'wrong number of arguments (given 0, expected 1)'
      )
    end
    it { is_expected.to respond_to :most_page_views }
    it { is_expected.to respond_to :most_unique_page_views }
    it { is_expected.to respond_to :print }
  end

  describe '#most_page_views' do
    it 'expect to return ordered array' do
      expect(subject.most_page_views).to eq(
        [
          { url: 'kling.info', views: 3 },
          { url: 'lueilwitz.info', views: 2 },
          { url: 'marks.net', views: 1 }
        ]
      )
    end
  end

  describe '#most_unique_page_views' do
    it 'expect to return ordered array' do
      expect(subject.most_page_views).to eq(
        [
          { url: 'lueilwitz.info', views: 2 },
          { url: 'kling.info', views: 1 },
          { url: 'marks.net', views: 1 }
        ]
      )
    end
  end

  describe '#print' do
    it do
      expect(subject.print(subject.most_page_views) { |url, views| "#{url} #{views} views\n" }).to output(
        'kling.info 3 views\nlueilwitz.info 2 views\nmarks.net 1 views'
      ).to_stdout
    end
    it do
      expect(subject.print(subject.most_page_views) { |url, views| "#{url} #{views} unique views\n" }).to output(
        'lueilwitz.info 2 unique views\nkling.info 1 unique views\nmarks.net 1 unique views'
      ).to_stdout
    end
  end
end
