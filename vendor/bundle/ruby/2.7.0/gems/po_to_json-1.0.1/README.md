# PoToJson

[![Gem Version](http://img.shields.io/gem/v/po_to_json.svg)](https://rubygems.org/gems/po_to_json)
[![Build Status](https://secure.travis-ci.org/webhippie/po_to_json.svg)](https://travis-ci.org/webhippie/po_to_json)
[![Code Climate](https://codeclimate.com/github/webhippie/po_to_json.svg)](https://codeclimate.com/github/webhippie/po_to_json)
[![Test Coverage](https://codeclimate.com/github/webhippie/po_to_json/badges/coverage.svg)](https://codeclimate.com/github/webhippie/po_to_json)
[![Dependency Status](https://gemnasium.com/webhippie/po_to_json.svg)](https://gemnasium.com/webhippie/po_to_json)

Convert gettext PO files to JSON to use in your javascript app, based on
po2json.pl by [DuckDuckGo, Inc.](http://duckduckgo.com/). Ideally you'll use
this on a Rake task that creates JSON versions of your PO files, which can
later be used from javascript with [Jed](http://slexaxton.github.io/Jed/)


## Versions

This gem is tested on the following versions automated through TravisCI:

* Ruby
  * 1.9.3
  * 2.0.0
  * 2.1.0
* Json
  * 1.6.8
  * 1.7.7
  * 1.8.2


## Installation

```ruby
gem "po_to_json", "~> 0.1.0"
```


## Usage

Most common use would be to generate a Jed ready javascript file. For example,
in a Rails project:

```ruby
require "po_to_json"

json = PoToJson.new(
  Rails.root.join("locale", "de", "app.po")
).generate_for_jed("de")

Rails.root.join("app", "assets", "javascripts", "locale", "de", "app.js").write(json)
```

If you need a pretty json, add `pretty: true` to `generate_for_jed`, like the
following example:

```ruby
require "po_to_json"

json = PoToJson.new(
  Rails.root.join("locale", "de", "app.po")
).generate_for_jed("de", pretty: true)

Rails.root.join("app", "assets", "javascripts", "locale", "de", "app.js").write(json)
```

The javascript file generated has a global "locales" object with an attribute
corresponding to the generated language:

```javascript
i18n = new Jed(locales["de"])
i18n.gettext("Hello World") // Should evaluate to "Hallo Welt"
```


## Contributing

Fork -> Patch -> Spec -> Push -> Pull Request


## Authors

* [Thomas Boerger](https://github.com/tboerger)
* [Nubis](https://github.com/nubis)
* [Other contributors](https://github.com/webhippie/po_to_json/graphs/contributors)


## License

MIT


## Copyright

```
Copyright (c) 2012-2015 Dropmysite.com <https://dropmyemail.com>
Copyright (c) 2015 Webhippie <http://www.webhippie.de>
```
