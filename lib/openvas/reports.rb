# frozen_string_literal: true

require 'time'

module Openvas
  class Reports < Client
    def self.all
      query = Nokogiri::XML::Builder.new { get_reports }
      query(query).xpath('//get_reports_response/report').map do |report|
        Openvas::Report.new(report)
      end
    end

    def self.find_by_id(id)
      query = Nokogiri::XML::Builder.new { get_reports(report_id: id) }
      Openvas::Report.new(query(query).at_xpath('//get_reports_response/report'))
    end
  end

  class Report
    attr_accessor :id, :name, :comment, :created_at, :updated_at

    def initialize(report)
      @id = report.at_xpath('@id').value
      @name = report.at_xpath('name').text
      @comment = report.at_xpath('comment').text
      @user = report.at_xpath('owner/name').text

      @created_at = Time.parse(report.at_xpath('creation_time').text)
      @updated_at = Time.parse(report.at_xpath('modification_time').text)
    end

    def results
      Openvas::Results.find_by_report_id(@id)
    end
  end
end
