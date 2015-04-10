module PuppetSpec
  FIXTURE_DIR = File.join(dir = File.expand_path(File.dirname(__FILE__)), "fixtures") unless defined?(FIXTURE_DIR)
end

require 'puppet'
require 'rspec-puppet'
require 'simplecov'
require 'puppetlabs_spec_helper/module_spec_helper'

module HieraPuppetHelper
  HIERA_PUPPET_VERSION=:newer
end

begin
  require 'hiera_puppet'
rescue LoadError => e
  HieraPuppetHelper::HIERA_PUPPET_VERSION=:older
  require 'puppet/parser/functions/hiera_hash'
end

SimpleCov.start do
  add_filter "/spec/"
end

module HieraPuppetSpec
  include PuppetSpec
  def self.configure()
    Puppet.settings[:confdir] = FIXTURE_DIR
    Puppet.settings[:hiera_config] = File.join(FIXTURE_DIR, 'hiera.yaml') if Puppet.settings.include?(:hiera_config)
    if HieraPuppetHelper::HIERA_PUPPET_VERSION == :newer
      ::HieraPuppet.hiera.config[:yaml][:datadir] = File.join(FIXTURE_DIR, 'hiera')
    end
  end
end

RSpec.configure do |config|
  config.before :each do
    HieraPuppetSpec.configure()
  end
end
