# frozen_string_literal: true

require 'nokogiri'

module Openvas
  class Auth < Client
    class InvalidLogin < StandardError; end

    # Do Login
    def self.login
      content = Nokogiri::XML::Builder.new do |xml|
        xml.authenticate do
          xml.credentials do
            xml.username Openvas::Config.username
            xml.password Openvas::Config.password
          end
        end
      end

      result = Nokogiri::XML(send_receive(content.to_xml))

      unless result.at_css('authenticate_response')[:status].eql?('200')
        raise AuthenticateError result.at_css('authenticate_response')[:status_text]
      end

      true
    end
  end
end
