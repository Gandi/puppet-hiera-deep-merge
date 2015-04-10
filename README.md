# Puppet-Hiera deep merge on demand

[![Build Status](https://travis-ci.org/gandi/puppet-hiera-deep-merge.svg?branch=master)](https://travis-ci.org/gandi/puppet-hiera-deep-merge)

## Why ?

Hiera 1.2 has bring the [deep_merge behavior](https://docs.puppetlabs.com/hiera/1/lookup_types.html#deep-merging-in-hiera--120) which is an large enhancement for managing stuff in Hiera. But merge behavior is a global settings in hiera and when migrating a large puppet code base, this may be error-prone. For this purpose, this module provides a new function named ``hiera_hash_merge`` which will use the `deep_merge` behavior but does not need a global switch.

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


