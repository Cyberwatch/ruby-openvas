# frozen_string_literal: true

require 'spec_helper'

describe Openvas::Client do
  describe '#version' do
    before(:each) do
      allow(Openvas::Client).to receive(:query).and_return(fixture_xml('openvas/client/version.xml'))
    end

    it 'get the version' do
      expect(Openvas::Client.version).to eq '7.0'
    end
  end
end
