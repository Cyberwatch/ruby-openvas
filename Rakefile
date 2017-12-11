# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

task default: :test

RSpec::Core::RakeTask.new do |spec|
  spec.verbose = false
  spec.pattern = './spec/{*/**/}*_spec.rb'
end

task :test do
  ENV['RACK_ENV'] = 'test'

  require './spec/spec_helper'
  Rake::Task['spec'].invoke
end
