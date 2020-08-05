# frozen_string_literal: true

require_relative '../../lib/visit'

RSpec.describe Visit do
  subject { Visit.new('kling.info') }

  describe '.initialize' do
    it do
      expect { Visit.new }.to raise_error(
        ArgumentError, 'wrong number of arguments (given 0, expected 1)'
      )
    end
    it { is_expected.to be_an_instance_of Visit }
    it { is_expected.to respond_to :url }
    it { is_expected.to respond_to :ips }
    it { is_expected.to respond_to :add }
  end

  describe '#url' do
    subject { Visit.new('kling.info') }
    it { expect(subject.url).to be_an_instance_of String }
    it { expect(subject.url).to eq('kling.info') }
  end

  describe '#ips' do
    subject { Visit.new('kling.info') }
    it { expect(subject.ips).to be_an_instance_of Array }
    it { expect(subject.ips).to be_empty }
  end

  describe '#add' do
    subject { Visit.new('kling.info') }
    it do
      expect { subject.add }.to raise_error(
        ArgumentError, 'wrong number of arguments (given 0, expected 1)'
      )
    end
    it { expect(subject.add('wiley_weimann@hessel.io')).to be_an_instance_of Array }
    it { expect(subject.add('crystal@sporer-torp.org')).to change(subject.ips, :size).by(1) }
  end
end
