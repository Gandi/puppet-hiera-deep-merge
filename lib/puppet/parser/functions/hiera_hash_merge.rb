module Puppet::Parser::Functions
  begin
    require 'hiera_puppet'

    newfunction(:hiera_hash_merge, :type => :rvalue) do |args|
      if args[0].is_a?(Array)
        args = args[0]
      end

      raise(Puppet::ParseError, "Please supply a 1 to 3 parameters") if args.length > 3

      key = args[0]
      default = args[1]
      override = args[2]

      old_merge_behavior = HieraPuppet.hiera.config[:merge_behavior]
      begin
        HieraPuppet.hiera.config[:merge_behavior] = :deeper
        answer = function_hiera_hash([key, default, override])
      ensure
        HieraPuppet.hiera.config[:merge_behavior] = old_merge_behavior
      end

      answer
    end
  rescue LoadError
    require 'puppet/parser/functions/hiera_hash'
    newfunction(:hiera_hash_merge, :type => :rvalue) do |args|

      if args[0].is_a?(Array)
        args = args[0]
      end

      raise(Puppet::ParseError, "Please supply a parameter to perform a Hiera lookup") if args.empty?

      key = args[0]
      default = args[1]
      override = args[2]

      configfile = File.join([Puppet.settings[:confdir], "hiera.yaml"])

      raise(Puppet::ParseError, "Hiera config file #{configfile} not readable") unless File.exist?(configfile)

      require 'hiera'
      require 'hiera/scope'

      config = YAML.load_file(configfile)
      config[:merge_behavior] = :deeper

      hiera = Hiera.new(:config => config)
      hiera_scope = Hiera::Scope.new(self)

      answer = hiera.lookup(key, default, hiera_scope, override, :hash)

      raise(Puppet::ParseError, "Could not find data item #{key} in any Hiera data file and no default supplied") if answer.nil?
      raise(Puppet::ParseError, "Could not find data item #{key} in any Hiera data file and no default supplied") if answer.empty?

      answer
    end
  end
end

