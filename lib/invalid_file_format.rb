# frozen_string_literal: true

class InvalidFileFormat < StandardError
  def initialize
    super('File format is invalid')
  end
end
