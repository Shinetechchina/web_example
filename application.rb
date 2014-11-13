ROOT = File.expand_path("..",__FILE__)
require "#{ROOT}/boot.rb"
require 'active_support'
require 'active_support/all'
require 'active_support/dependencies'
require 'active_support/file_update_checker.rb'
Dir["#{ROOT}/app/*"].each do |f|
  ActiveSupport::Dependencies.autoload_paths << f
end
require "#{ROOT}/reloader.rb"
