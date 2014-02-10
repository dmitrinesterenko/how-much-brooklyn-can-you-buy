# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)
#nice print is weird, a part of core ruby but not, not a gem but needs a require
require 'pp'
require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
