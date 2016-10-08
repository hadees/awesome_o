require 'awesome_o/version'
require 'awesome_o/configuration'
require 'awesome_o/cart'
require 'awesome_o/item'
require 'awesome_o/item_collection'

module AwesomeO
  def self.config
    @config ||= Configuration.new
    yield @config if block_given?
    @config
  end
end
