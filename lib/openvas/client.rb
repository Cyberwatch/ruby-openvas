# frozen_string_literal: true

require 'uri'
require 'socket'
require 'openssl'

module Openvas
  class Client
    # buffer size for socket
    BLOCK_SIZE = 1024 * 16

    # Connect the websocket
    def self.connect
      # Retrieve URI
      raise ConfigError, 'URL not configured' unless Openvas::Config.url

      begin
        uri = URI.parse(Openvas::Config.url)

        plain_socket = TCPSocket.open(uri.host, uri.port)
        self.socket = OpenSSL::SSL::SSLSocket.new(plain_socket, OpenSSL::SSL::SSLContext.new)

        # Enable to close socket and SSL layer together
        socket.sync_close = true
        socket.connect
      rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH, OpenSSL::SSL::SSLError, SocketError,
             URI::InvalidURIErro => e
        raise ConnectionError, e
      end

      true
    end

    def self.disconnect
      return unless socket

      begin
        socket.close
        self.socket = nil
      rescue SocketError => e
        raise ConnectionError, e
      end
    end

    def self.version
      query = Nokogiri::XML::Builder.new { get_version }
      query(query).at_xpath('/get_version_response/version').text
    end

    def self.query(data)
      res = Nokogiri::XML(send_receive(data.to_xml))

      raise QueryError, 'Unknown query error' unless res.at_xpath('//@status')&.value == '200'

      res
    end

    # Private class methods
    class << self
      private

      # send_receive data
      def send_receive(send)
        socket.syswrite(send)

        buffer = ''
        loop do
          last_part = socket.sysread(BLOCK_SIZE)
          buffer += last_part
          break if last_part.size < BLOCK_SIZE
        end
        buffer
      end

      def socket
        Openvas::Config.socket
      end

      def socket=(socket)
        Openvas::Config.socket = socket
      end
    end
  end
end
