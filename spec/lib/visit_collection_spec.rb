# frozen_string_literal: true

require_relative '../../lib/visit_collection'

RSpec.describe VisitCollection do
  subject { VisitCollection.new }

  describe '.initialize' do
    it { is_expected.to be_an_instance_of VisitCollection }
    it { is_expected.to respond_to :all }
    it { is_expected.to respond_to :add }
    it { is_expected.to respond_to :find }
    it { is_expected.to respond_to :find_or_add }
  end

  describe '#all' do
    it { expect(subject.all).to be_an_instance_of Array }
    it { expect(subject.all).to be_empty }
  end

  describe '#find' do
    before do
      subject.add('oconnell-parisian.io', 'wiley_weimann@hessel.io')
    end
    it { expect { subject.find }.to raise_error(ArgumentError, 'wrong number of arguments (given 0, expected 1)') }
    it { expect(subject.find('kling.info')).to be_nil }
    it { expect(subject.find('oconnell-parisian.io')).to be_an_instance_of Visit }
  end

  describe '#add' do
    it { expect { subject.add }.to raise_error(ArgumentError, 'wrong number of arguments (given 0, expected 2)') }
    it { expect(subject.add('kling.info', 'wiley_weimann@hessel.io')).to be_an_instance_of Visit }
    it { expect(subject.add('rutherford.co', 'wiley_weimann@hessel.io')).to change(subject.all, :size).by(1) }
    it { expect(subject.add('rutherford.co', 'monte.gaylord@kreiger.org')).not_to change(subject.all, :size).by(1) }
  end

  describe '#find_or_add' do
    it do
      expect { subject.find_or_add }.to raise_error(
        ArgumentError, 'wrong number of arguments (given 0, expected 2)'
      )
    end

    it { expect(subject.find_or_add('kling.info', 'wiley_weimann@hessel.io')).to be_an_instance_of Visit }
    it { expect(subject.add('rutherford.co', 'wiley_weimann@hessel.io')).to change(subject.all, :size).by(1) }
    it { expect(subject.add('rutherford.co', 'monte.gaylord@kreiger.org')).not_to change(subject.all, :size).by(1) }
  end
end
