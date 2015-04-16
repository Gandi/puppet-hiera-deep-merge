# Puppet-Hiera deep merge on demand

[![Build Status](https://travis-ci.org/Gandi/puppet-hiera-deep-merge.svg?branch=master)](https://travis-ci.org/Gandi/puppet-hiera-deep-merge)

## Why ?

Hiera 1.2 introduces [deep_merge behavior](https://docs.puppetlabs.com/hiera/1/lookup_types.html#deep-merging-in-hiera--120),
which is a major enhancement for managing stuff in Hiera. But merge
behavior is a global setting in Hiera, so migration of large puppet
code bases can be prone to errors. This module provides a new
function named ``hiera_hash_merge`` which uses the `deep_merge`
behavior but does not need a global switch.

## Usage

common.yaml:
``` yaml
key:
    subdict:
        hidden: in native mode
```

node.yaml:
```
key:
   subdict:
       anotherkey: foo
```

``` puppet
$value = hiera_hash_merge('key')
$value['subdict']['hidden']
```


## Development

```
bundle install --path vendor/bundle
bundle exec rake spec
```


