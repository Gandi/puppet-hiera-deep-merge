source ENV['GEM_SOURCE'] || 'https://rubygems.org'

def location_for(place, fake_version = nil)
  if place =~ /^(git[:@][^#]*)#(.*)/
    [fake_version, { :git => $1, :branch => $2, :require => false }].compact
  elsif place =~ /^file:\/\/(.*)/
    ['>= 0', { :path => File.expand_path($1), :require => false }]
  else
    [place, { :require => false }]
  end
end

group :development, :test do
  gem 'rake', '~> 10.1.0',       :require => false
  gem 'rspec-puppet',            :require => false
  gem 'puppetlabs_spec_helper',  :require => false
  gem 'rspec-system',            :require => false
  gem 'rspec-system-puppet',     :require => false
  gem 'rspec-system-serverspec', :require => false
  gem 'serverspec',              :require => false
  gem 'puppet-lint',             :require => false
  gem 'pry',                     :require => false
  gem 'simplecov',               :require => false
  gem 'beaker',                  :require => false
  gem 'beaker-rspec',            :require => false
end

if ENV['PUPPET_VERSION']
  gem 'puppet', *location_for(ENV['PUPPET_VERSION'])
else
  gem 'puppet', :require => false
end

if ENV['HIERA_PUPPET_VERSION']
  if ENV['HIERA_PUPPET_VERSION'] == '1.0.0rc1'
    gem 'hiera-puppet', '1.0.0rc1', :git => 'https://github.com/puppetlabs/hiera-puppet.git', :tag => '1.0.0rc1'
    gem 'hiera', '1.3.4', :git => 'https://github.com/puppetlabs/hiera.git', :tag => '1.3.4'
  else
    gem 'hiera-puppet', *location_for(ENV['HIERA_PUPPET_VERSION'])
  end
end

gem 'deep_merge'



