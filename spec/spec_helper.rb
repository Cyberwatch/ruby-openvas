# frozen_string_literal: true

require 'coveralls'
Coveralls.wear!

require 'openvas'

def fixture(path)
  File.open(File.dirname(__FILE__) + '/fixtures/' + path).read
end

def fixture_xml(path)
  Nokogiri::XML(fixture(path))
end

def fixture_query(path)
  Nokogiri::XML(fixture(path))
end
