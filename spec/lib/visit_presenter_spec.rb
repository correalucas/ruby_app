# frozen_string_literal: true

require_relative '../../lib/visit_presenter'
require_relative '../../lib/visit_collection'

RSpec.describe VisitPresenter do
  let(:visit_collection) do
    visit_collection = VisitCollection.new
    visit_collection.find_or_add('kling.info', 'bruce.klocko@reichert.net')
    visit_collection.find_or_add('kling.info', 'bruce.klocko@reichert.net')
    visit_collection.find_or_add('lueilwitz.info', 'wiley_weimann@hessel.io')
    visit_collection.find_or_add('lueilwitz.info', 'bruce.klocko@reichert.net')
    visit_collection.find_or_add('kling.info', 'bruce.klocko@reichert.net')
    visit_collection.find_or_add('marks.net', 'brittaney@strosin.info')
    visit_collection
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
    it { expect(VisitPresenter).to respond_to :print }
    it { expect(VisitPresenter).to respond_to :sort }
  end

  describe '#most_page_views' do
    it 'expect to return most_page_views array' do
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
    it 'expect to return most_unique_page_views array' do
      expect(subject.most_unique_page_views).to eq(
        [
          { url: 'kling.info', views: 1 },
          { url: 'lueilwitz.info', views: 2 },
          { url: 'marks.net', views: 1 }
        ]
      )
    end
  end

  describe '#average_page_views' do
    it 'expect to return the average page views' do
      expect(subject.average_page_views).to eq(
        [
          { url: 'kling.info', views: 3 },
          { url: 'lueilwitz.info', views: 1 },
          { url: 'marks.net', views: 1 }
        ]
      )
    end
  end

  describe '.sort' do
    it 'expect to return ordered most_page_views array' do
      expect(VisitPresenter.sort(subject.most_page_views)).to eq(
        [
          { url: 'kling.info', views: 3 },
          { url: 'lueilwitz.info', views: 2 },
          { url: 'marks.net', views: 1 }
        ]
      )
    end

    it 'expect to return ordered most_unique_page_views array' do
      expect(VisitPresenter.sort(subject.most_unique_page_views)).to eq(
        [
          { url: 'lueilwitz.info', views: 2 },
          { url: 'marks.net', views: 1 },
          { url: 'kling.info', views: 1 }
        ]
      )
    end
  end

  describe '.print' do
    let(:sorted_most_page_views) { VisitPresenter.sort(subject.most_page_views) }
    let(:sorted_most_unique_page_views) { VisitPresenter.sort(subject.most_unique_page_views) }
    let(:average_page_views) { subject.average_page_views }

    it do
      expect do
        VisitPresenter.print(sorted_most_page_views) { |url, views| print "#{url} #{views} views\n" }
      end.to output(
        /kling.info 3 views\nlueilwitz.info 2 views\nmarks.net 1 views/
      ).to_stdout
    end

    it do
      expect do
        VisitPresenter.print(sorted_most_unique_page_views) { |url, views| print "#{url} #{views} unique views\n" }
      end.to output(
        /lueilwitz.info 2 unique views\nmarks.net 1 unique views\nkling.info 1 unique views/
      ).to_stdout
    end

    it do
      expect do
        VisitPresenter.print(average_page_views) { |url, views| print "#{url} average: #{views} views\n" }
      end.to output(
        /kling.info average: 3 views\nlueilwitz.info average: 1 views\nmarks.net average: 1 views/
      ).to_stdout
    end
  end
end
