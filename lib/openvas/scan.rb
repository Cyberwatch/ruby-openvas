# frozen_string_literal: true

require 'time'

module Openvas
  # Class used to interact with OpenVAS' scans
  class Scan < Client
    attr_accessor :id, :name, :comment, :status, :target, :user, :created_at, :updated_at, :trend

    def initialize(scan)
      @id = scan.at_xpath('@id').value
      @name = scan.at_xpath('name').text
      @comment = scan.at_xpath('comment').text
      @user = scan.at_xpath('owner/name').text
      @trend = scan.at_xpath('trend').text
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
      Openvas::Result.find_by_report_id(@last_report_id)
    end

    def finished?
      @status == 'Done'
    end

    class << self
      def all
        data = Nokogiri::XML::Builder.new { get_tasks }

        query(data).xpath('//get_tasks_response/task').map do |scan|
          new(scan)
        end
      end

      def find_by(id:)
        data = Nokogiri::XML::Builder.new { get_tasks(task_id: id) }
        new(query(data).at_xpath('//get_tasks_response/task'))
      end
    end
  end
end
