# frozen_string_literal: true

require 'nokogiri'

module Openvas
  class Auth < Client
    class InvalidLogin < StandardError; end

    # Do Login
    def self.login
      raise InvalidLogin, 'Please configure the username' unless Openvas::Config.username
      raise InvalidLogin, 'Please configure the password' unless Openvas::Config.password

      content = Nokogiri::XML::Builder.new do |xml|
        xml.authenticate do
          xml.credentials do
            xml.username Openvas::Config.username
            xml.password Openvas::Config.password
          end
        end
      end

      query(content)

      true
    end
  end
end
