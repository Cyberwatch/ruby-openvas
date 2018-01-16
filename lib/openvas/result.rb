# frozen_string_literal: true

require 'time'

module Openvas
  # Class used to interact with OpenVAS' scans results
  class Result < Client
    attr_accessor :id, :name, :comment, :description, :host, :user, :port, :severity, :cves, :created_at, :updated_at

    def initialize(result)
      @id = result.at_xpath('@id').value
      @name = result.at_xpath('name').text
      @comment = result.at_xpath('comment').text
      @user = result.at_xpath('owner/name').text
      @host = result.at_xpath('host').text
      @port = result.at_xpath('port').text
      @severity = result.at_xpath('severity').text
      @description = result.at_xpath('description').text
      @cves = result.at_xpath('nvt').at_xpath('cve').text.split(',').map(&:strip)

      @created_at = Time.parse(result.at_xpath('creation_time').text)
      @updated_at = Time.parse(result.at_xpath('modification_time').text)
    end

    def results
      Openvas::Result.find_by_report_id(@id)
    end

    class << self
      MAX_RESULTS = 1000

      def all
        # TODO: implement pagination
        query = Nokogiri::XML::Builder.new { get_results(filter: "first=1 rows=#{MAX_RESULTS}") }

        query(query).xpath('//get_results_response/result').map do |result|
          new(result)
        end
      end

      def find_by(id:)
        query = Nokogiri::XML::Builder.new { get_results(result_id: id) }
        new(query(query).at_xpath('//get_results_response/result'))
      end

      def find_by_report_id(id)
        # TODO: implement pagination
        query = Nokogiri::XML::Builder.new { get_results(filter: "report_id=#{id} first=1 rows=#{MAX_RESULTS}") }

        query(query).xpath('//get_results_response/result').map do |result|
          new(result)
        end
      end
    end
  end
end
