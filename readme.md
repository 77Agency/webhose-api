
Webhose-api
====
[Webhose-api](http://github.com/77agency/webhose-api) is a Webhose api library for Ruby


Installation
---

In Bundler:
```ruby
gem "webhose-api"
```

Otherwise:
```bash
[sudo|rvm] gem install webhose-api
```

Usage
---------

```ruby
@api = Webhose::API.new(token)
@api.search("test")
