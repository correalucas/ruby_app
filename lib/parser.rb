# frozen_string_literal: true

class Parser
  def initialize(path)
    raise(FileNotFound, path) unless File.exist?(path)

    @path = File.read(path)
  end

  def parse
    path.lines.map do |line|
      values = line.split(' ')

      raise InvalidFileFormat if values.size != 2

      url, ip = values

      next yield(url, ip) if block_given?

      { url: url, ip: ip }
    end
  end

  private

  attr_reader :path
end
