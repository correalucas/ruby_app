# frozen_string_literal: true

require_relative '../../lib/file_not_found'

RSpec.describe FileNotFound do
  subject { FileNotFound.new('/path/to/file') }

  describe '.initialize' do
    it { expect { FileNotFound.new }.to raise_error(ArgumentError, 'wrong number of arguments (given 0, expected 1)') }
    it { expect(subject.message).to eq('No such file or directory: /path/to/file') }
  end
end
