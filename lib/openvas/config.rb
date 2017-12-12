# frozen_string_literal: true

module Openvas
  module Config
    class RequiredOptionMissing < RuntimeError; end
    module_function

    attr_accessor :url, :username, :password, :socket
  end
end
