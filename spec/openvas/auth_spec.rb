# frozen_string_literal: true

require 'spec_helper'

describe Openvas::Auth do
  describe '#login' do
    before(:each) do
      allow(Openvas::Auth).to receive(:query).and_return(nil)
    end

    it 'authenticate' do
      Openvas.configure do |config|
        config.url = 'https://localhost:9390'
        config.username = 'admin'
        config.password = 'admin'
      end

      expect(Openvas::Auth.login).to be_truthy
    end

    it 'without username' do
      Openvas::Config.username = nil
      expect { Openvas::Auth.login }.to raise_exception(Openvas::Auth::InvalidLogin)
    end

    it 'without password' do
      Openvas::Config.password = nil
      expect { Openvas::Auth.login }.to raise_exception(Openvas::Auth::InvalidLogin)
    end
  end
end
