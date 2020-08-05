# frozen_string_literal: true

class Visit
  attr_reader :url, :ips

  def initialize(url)
    @url = url
    @ips = []
  end

  def add(ip)
    ips.push(ip)
  end

  private

  attr_writer :ips
end
