require 'bundler/setup'
require 'rails'
require "ostruct"

Bundler.require

Dir["./spec/support/*.rb"].each{|f| require f }
