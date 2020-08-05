# frozen_string_literal: true

require_relative '../../lib/visit_collection'
require_relative '../../lib/visit'

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
    let(:visit1) do
      visit = Visit.new('kling.info')
      visit.add('wiley_weimann@hessel.io')
      visit
    end

    before do
      subject.add(visit1)
    end
    it { expect { subject.find }.to raise_error(ArgumentError, 'wrong number of arguments (given 0, expected 1)') }
    it { expect(subject.find('oconnell-parisian.io')).to be_nil }
    it { expect(subject.find('kling.info')).to be_an_instance_of Visit }
  end

  describe '#add' do
    let(:visit1) do
      visit = Visit.new('kling.info')
      visit.add('wiley_weimann@hessel.io')
      visit
    end

    let(:visit2) do
      visit = Visit.new('rutherford.co')
      visit.add('wiley_weimann@hessel.io')
      visit
    end



    it { expect { subject.add }.to raise_error(ArgumentError, 'wrong number of arguments (given 0, expected 1)') }
    it { expect(subject.add(visit1)).to be_an_instance_of Array }
    it { expect { subject.add(visit2) }.to change(subject.all, :size).by(1) }

    context 'not add duplicated visit' do
      before { subject.add(visit2) }
      it { expect { subject.add(visit2) }.to change(subject.all, :size).by(0) }
    end

  end

  describe '#find_or_add' do
    it do
      expect { subject.find_or_add }.to raise_error(
        ArgumentError, 'wrong number of arguments (given 0, expected 2)'
      )
    end

    it { expect(subject.find_or_add('kling.info', 'wiley_weimann@hessel.io')).to be_an_instance_of Visit }
    it { expect { subject.find_or_add('rutherford.co', 'wiley_weimann@hessel.io') }.to change(subject.all, :size).by(1) }
    context 'not add duplicated visit' do
      before { subject.find_or_add('rutherford.co', 'monte.gaylord@kreiger.org') }
      it do
        expect { subject.find_or_add('rutherford.co', 'monte.gaylord@kreiger.org')}.to change(
          subject.all, :size
        ).by(0)
      end
    end
  end
end
