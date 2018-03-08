# frozen_string_literal: true

require 'openvas/version'

require 'openvas/config'
require 'openvas/client'
require 'openvas/auth'

require 'openvas/scan'
require 'openvas/reports'
require 'openvas/result'

module Openvas
  extend self

  class OpenvasError < StandardError; end
  class AuthError < OpenvasError; end
  class ConnectionError < OpenvasError; end
  class ConfigError < OpenvasError; end
  class QueryError < OpenvasError; end

  def configure
    block_given? ? yield(Config) : Config
    %w[url username password].each do |key|
      next unless Openvas::Config.instance_variable_get("@#{key}").nil?
      raise ConfigError,
            "Configuration parameter missing: '#{key}'. " \
            'Please add it to the Openvas.configure block'
    end
  end
  alias config configure
end
