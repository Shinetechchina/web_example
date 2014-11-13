require 'rubygems'
require 'bundler'
if Gem::Version.new(Bundler::VERSION) <= Gem::Version.new("0.9.24")
    raise RuntimeError, "Your bundler version is too old." +
         "Run `gem install bundler` to upgrade."
end
# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
Bundler.require :default
