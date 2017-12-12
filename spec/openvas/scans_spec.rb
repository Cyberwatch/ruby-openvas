# frozen_string_literal: true

require 'spec_helper'

describe Openvas::Scans do
  describe '#all' do
    before(:each) do
      allow(Openvas::Scans).to receive(:query).and_return(fixture_xml('openvas/scans/all.xml'))
    end

    it 'list scans' do
      expect(Openvas::Scans.all.count).to eq 2
    end
  end

  describe '#find_by_id' do
    before(:each) do
      allow(Openvas::Scans).to receive(:query).and_return(fixture_xml('openvas/scans/find_by_id.xml'))
    end

    it 'get the version' do
      expect(Openvas::Scans.find_by_id('96625625-8e22-4b1c-9c65-4ddf80f78d20')).to be_a(Openvas::Scan)
    end

    context 'scan' do
      let(:scan) { Openvas::Scans.find_by_id('96625625-8e22-4b1c-9c65-4ddf80f78d20') }

      it '#id' do
        expect(scan.id).to eq '96625625-8e22-4b1c-9c65-4ddf80f78d20'
      end

      it '#name' do
        expect(scan.name).to eq 'shellshock_01'
      end

      it '#comment' do
        expect(scan.comment).to eq ''
      end

      it '#user' do
        expect(scan.user).to eq 'admin'
      end

      it '#status' do
        expect(scan.status).to eq 'Done'
      end

      it '#finished' do
        expect(scan.finished?).to be_truthy
      end

      it '#created_at' do
        expect(scan.created_at.to_s).to eq '2017-12-11 16:40:16 UTC'
      end

      it '#updated_at' do
        expect(scan.updated_at.to_s).to eq '2017-12-12 08:13:44 UTC'
      end
    end
  end
end
