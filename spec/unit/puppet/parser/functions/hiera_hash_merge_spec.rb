#! /usr/bin/env ruby -S rspec
require 'spec_helper'

describe 'the hiera_hash_merge function' do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  it 'should exist' do
    Puppet::Parser::Functions.function('hiera_hash_merge').should == 'function_hiera_hash_merge'
  end

  it 'should require a key argument' do
    expect { scope.function_hiera_hash_merge([]) }.to raise_error(Puppet::ParseError)
  end

  it 'should merge two hash with deep merge' do
    result = scope.function_hiera_hash_merge(['common'])
    result['subdict']['hidden'].should(eq('in native behavior'))
  end

  it 'should not alter regular merge behaviour' do
    result = scope.function_hiera_hash(['common'])
    result['subdict']['hidden'].should be_nil
  end

  it 'should throw an exception if key does not exists' do
    expect { scope.function_hiera_hash_merge(['invalid']) }.to raise_error(Puppet::ParseError)
  end

  it 'should accept array as arguments' do
    scope.function_hiera_hash_merge([['common']])
  end
end

