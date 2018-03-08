# frozen_string_literal: true

require 'spec_helper'

describe Openvas::Client do
  describe '.connect' do
    subject { Openvas::Client.connect }

    context 'when failing' do
      before do
        allow(Openvas::Config).to receive(:url) { 'https://localhost:9390' }
      end

      it 'raises ConnectionError' do
        expect { subject }.to raise_error Openvas::ConnectionError
      end
    end
  end

  describe '#version' do
    before(:each) do
      allow(Openvas::Client).to receive(:query).and_return(fixture_xml('openvas/client/version.xml'))
    end

    it 'get the version' do
      expect(Openvas::Client.version).to eq '7.0'
    end
  end
end
