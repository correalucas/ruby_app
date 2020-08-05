# frozen_string_literal: true

class FileNotFound < StandardError
  attr_reader :path

  def initialize(path)
    @path = path
    super("No such file or directory: #{@path}")
  end
end
