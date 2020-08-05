# frozen_string_literal: true

require_relative './visit'

class VisitCollection
  attr_reader :all

  def initialize
    @all = []
  end

  def find_or_add(url, ip)
    visit = find(url) || Visit.new(url)

    add(visit)

    visit.add(ip)

    visit
  end

  def find(url)
    all.find { |visit| visit.url == url }
  end

  def add(visit)
    all.push(visit) if find(visit.url).nil?
  end

  private

  attr_writer :all
end
