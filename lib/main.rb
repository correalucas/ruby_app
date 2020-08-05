# frozen_string_literal: true

require_relative './parser'
require_relative './visit_collection'
require_relative './visit_presenter'

class Main
  def initialize(path)
    @path = path
  end

  def execute
    visit_collection = parse

    visit_presenter = VisitPresenter.new(visit_collection)
    most_page_views = VisitPresenter.sort(visit_presenter.most_page_views)
    most_unique_page_views = VisitPresenter.sort(visit_presenter.most_unique_page_views)

    print "most page views\n"
    VisitPresenter.print(most_page_views) { |url, views| print "#{url} #{views} views\n" }

    print "\n\nmost unique page views\n"
    VisitPresenter.print(most_unique_page_views) { |url, views| print "#{url} #{views} unique views\n" }

    false
  end

  private

  attr_reader :path

  def parse
    parser = Parser.new(path)
    visit_collection = VisitCollection.new

    parser.parse do |url, ip|
      visit_collection.find_or_add(url, ip)
    end

    visit_collection
  end
end
