# frozen_string_literal: true

require 'spec_helper'

describe Openvas::Scan do
  let(:scan) { Openvas::Scan.find_by_id('96625625-8e22-4b1c-9c65-4ddf80f78d20') }

  describe '.all' do
    before { allow(Openvas::Scan).to receive(:query).and_return(fixture_xml('openvas/scans/all.xml')) }

    it 'list scans' do
      expect(Openvas::Scan.all.count).to eq 2
    end
  end

  describe '.find_by_id' do
    before { allow(Openvas::Scan).to receive(:query).and_return(fixture_xml('openvas/scans/find_by_id.xml')) }

    it 'returns an Openvas::Scan object' do
      expect(scan).to be_a(Openvas::Scan)
    end

    it 'retrieves the scan\'s id' do
      expect(scan.id).to eq '96625625-8e22-4b1c-9c65-4ddf80f78d20'
    end

    it 'retrieves the scan\'s name' do
      expect(scan.name).to eq 'shellshock_01'
    end

    it 'retrieves the scan\'s comment' do
      expect(scan.comment).to be_empty
    end

    it 'retrieves the scan\'s user' do
      expect(scan.user).to eq 'admin'
    end

    it 'retrieves the scan\'s status' do
      expect(scan.status).to eq 'Done'
    end

    it 'retrieves the scan\'s creation date' do
      expect(scan.created_at.to_s).to eq '2017-12-11 16:40:16 UTC'
    end

    it 'retrieves the scan\'s modification date' do
      expect(scan.updated_at.to_s).to eq '2017-12-12 08:13:44 UTC'
    end
  end

  describe '#finished?' do
    before { allow(Openvas::Scan).to receive(:query).and_return(fixture_xml('openvas/scans/find_by_id.xml')) }

    context 'when the status is Done' do
      before { scan.status = 'Done' }

      it 'returns true' do
        expect(scan.finished?).to be_truthy
      end
    end

    context 'when the status is not Done' do
      before { scan.status = 'Running' }

      it 'returns false' do
        expect(scan.finished?).to be_falsey
      end
    end
  end
end
