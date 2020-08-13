# frozen_string_literal: true

require_relative '../../lib/main'

RSpec.describe Main do
  subject { Main.new('./spec/fixtures/webserver.log') }

  describe '.initialize' do
    it { expect { Main.new }.to raise_error(ArgumentError, 'wrong number of arguments (given 0, expected 1)') }
    it { is_expected.to be_an_instance_of Main }
    it { is_expected.to respond_to :execute }
  end

  describe '#execute' do
    it { expect { subject.execute }.to output(/most page views/).to_stdout }
    it { expect { subject.execute }.to output(/most unique page views/).to_stdout }
    it { expect { subject.execute }.to output(/average page views/).to_stdout }
  end
end
