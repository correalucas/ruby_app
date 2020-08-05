# frozen_string_literal: true

require_relative '../../lib/parser'

RSpec.describe Parser do
  subject { Parser.new('./spec/fixtures/webserver.log') }

  describe '.initialize' do
    it { expect { Parser.new }.to raise_error(ArgumentError, 'wrong number of arguments (given 0, expected 1)') }
    it do
      expect { Parser.new('some/path/to/file.log') }.to raise_error(
        FileNotFound, 'No such file or directory: some/path/to/file.log'
      )
    end
    it { is_expected.to be_an_instance_of Parser }
    it { is_expected.to respond_to :parse }
  end

  describe '#parse' do
    context 'parse without block' do
      subject do
        parser = Parser.new('./spec/fixtures/webserver.log')
        parser.parse
      end
      it { is_expected.to be_an_instance_of Array }
      it { expect(subject.first).to be_an_instance_of Hash }
      it { expect(subject.first).to have_key :url }
      it { expect(subject.first).to have_key :ip }
    end

    context 'parse with block given' do
      subject do
        parser = Parser.new('./spec/fixtures/webserver.log')
        parser.parse { |url, ip| "#{url} #{ip}" }
      end
      it { is_expected.to be_an_instance_of Array }
      it { expect(subject.first).to be_an_instance_of String }
      it { expect(subject.first).to eq('kutch.name brandy_conroy@prosacco.com') }
    end

    context 'invalid file' do
      subject { Parser.new('./spec/fixtures/invalid_file.log') }

      it { expect { subject.parse }.to raise_error(InvalidFileFormat, 'File format is invalid') }
    end
  end
end
