# frozen_string_literal: true

require_relative '../../lib/invalid_file_format'

RSpec.describe InvalidFileFormat do
  subject { InvalidFileFormat.new }

  describe '.initialize' do
    it { expect(subject.message).to eq('File format is invalid') }
  end
end
