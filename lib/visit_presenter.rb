# frozen_string_literal: true

class VisitPresenter
  def initialize(collection)
    @visit_collection = collection
  end

  def views_collection
    visit_collection.all.map do |visit|
      yield(visit.url, visit.ips)
    end
  end

  def most_page_views
    views_collection { |url, ips| { url: url, views: ips.size } }
  end

  def most_unique_page_views
    views_collection { |url, ips| { url: url, views: ips.uniq.size } }
  end

  def average_page_views
    views_collection { |url, ips| { url: url, views: ips.size / ips.uniq.size } }
  end

  def self.sort(collection)
    collection.sort_by { |vc| vc[:views] }.reverse
  end

  def self.print(collection)
    collection.map do |visit|
      yield(visit[:url], visit[:views])
    end

    collection
  end

  private

  attr_reader :visit_collection
end
