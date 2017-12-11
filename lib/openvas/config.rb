# frozen_string_literal: true

module Openvas
  module Config
    class RequiredOptionMissing < RuntimeError; end
    extend self

    attr_accessor :url, :username, :password, :socket
  end
end
