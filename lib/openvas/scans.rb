# frozen_string_literal: true

require 'time'

module Openvas
  class Scans < Client
    def self.all
      query = Nokogiri::XML::Builder.new { get_tasks }
      query(query).xpath('//get_tasks_response/task').map do |scan|
        Openvas::Scan.new(scan)
      end
    end

    def self.find_by_id(id)
      query = Nokogiri::XML::Builder.new { get_tasks(task_id: id) }
      Openvas::Scan.new(query(query).at_xpath('//get_tasks_response/task'))
    end
  end

  class Scan
    attr_accessor :id, :name, :comment, :status, :target, :created_at, :updated_at

    def initialize(scan)
      @id = scan.at_xpath('@id').value
      @name = scan.at_xpath('name').text
      @comment = scan.at_xpath('comment').text
      @user = scan.at_xpath('owner/name').text

      @status = scan.at_xpath('status').text
      @target = scan.at_xpath('target')&.first_element_child&.text

      @created_at = Time.parse(scan.at_xpath('creation_time').text)
      @updated_at = Time.parse(scan.at_xpath('modification_time').text)

      @last_report_id = scan.at_xpath('last_report/report/@id')&.value
    end

    def last_report
      Openvas::Reports.find_by_id(@last_report_id)
    end

    def last_results
      Openvas::Results.find_by_report_id(@last_report_id)
    end

    def finished?
      return true if @status.eql? 'Done'

      false
    end
  end
end
