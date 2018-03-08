# frozen_string_literal: true

require 'nokogiri'

module Openvas
  class Auth < Client
    # Do Login
    def self.login
      raise ConfigError, 'Username not configured' unless Openvas::Config.username
      raise ConfigError, 'Password not configured' unless Openvas::Config.password

      content = Nokogiri::XML::Builder.new do |xml|
        xml.authenticate do
          xml.credentials do
            xml.username Openvas::Config.username
            xml.password Openvas::Config.password
          end
        end
      end

      begin
        query(content)
      rescue QueryError
        raise AuthError, 'Invalid login or password'
      end

      true
    end
  end
end
