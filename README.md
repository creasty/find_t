find_t
======

**Find locale files where translation for key is defined.**

- Lookup all defined translations through languages
- Detect conflicts for the same translation key across files


Installation
------------

```sh
$ gem install find_t
```

Or add the gem to your Gemfile.

```ruby
gem 'find_t'
```


Synopsis
--------

```
find_t [--rails] {key}
```

| Option    | Description                                   |
| --------- | --------------------------------------------- |
| `--rails` | Include full locale files in Rails' load path |
| `{key}`   | A translation key to search for               |


Sample
------

```sh
$ find_t 'exception.projectshow'
Starting find_t at /Users/ykiwng/Develop/wantedly/wantedly
Scanning...

==> en

- config/locales/99_naka/en.yml:23
  "Sorry, you have to sign up to view this page!"

==> ja

- config/locales/01_model/ja.yml:3
  "この募集は、現在非公開です"
- config/locales/99_naka/ja.yml:23 [CONFLICTED]
  "この募集は、現在非公開です"
```


Using Ruby API
--------------

```ruby
require 'find_t'

scanner = FindT::Scanner.new(
  root_path: '/Users/ykiwng/Develop/wantedly/wantedly',
  rails:     false,
)

scanner.scan 'exception.projectshow'
#=> [
#     {
#       locale: 'en',
#       file:   '/User/ykiwng/Develop/wantedly/wantedly/config/locales/99_naka/en.yml',
#       line:   23,
#       text:   '"Sorry, you have to sign up to view this page!"',
#     },
#     ...
#   ]
```


License
-------

This project is copyright by [Creasty](http://creasty.com), released under the MIT lisence.  
See `LICENSE` file for details.
