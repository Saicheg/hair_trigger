# Changelog

## 0.2.x

### 0.2.12

* fix dependencies to reduce conflicts with other gems

### 0.2.11

* fix model migrations with `of`, `for_each` and `declare` ([#36](https://github.com/jenseng/hair_trigger/issues/36))
* clarify docs re: NOTICE ([#35](https://github.com/jenseng/hair_trigger/issues/35))

### 0.2.10

* `of` shorthand for column updates ([#32](https://github.com/jenseng/hair_trigger/issues/32))
* `declare` option for Postgres ([#34](https://github.com/jenseng/hair_trigger/issues/34))

### 0.2.9

* `nowrap` option for Postgres to support easy reuse of existing functions ([#31](https://github.com/jenseng/hair_trigger/pull/31))

### 0.2.8

* Rails 4.1 support ([#30](https://github.com/jenseng/hair_trigger/issues/30))
* Fix `DEFINER` issues in mysql ([#29](https://github.com/jenseng/hair_trigger/issues/29))

### 0.2.7

* Support chaining within trigger groups ([#22](https://github.com/jenseng/hair_trigger/issues/22))
* Warn when `name` is used incorrectly for the current adapter ([#22](https://github.com/jenseng/hair_trigger/issues/22))
* Misc doc improvements
* Minor bug fixes ([#26](https://github.com/jenseng/hair_trigger/issues/26) and [799ac5e](https://github.com/jenseng/hair_trigger/commit/799ac5e))

### 0.2.6

* Ruby 2.1 support ([#23](https://github.com/jenseng/hair_trigger/issues/23))
* Fix `HairTrigger::migrations_current?` bug ([#25](https://github.com/jenseng/hair_trigger/issues/25))

### 0.2.5

* Update ruby_parser dependency

### 0.2.4

* Rails 4 support
* Ruby 2 support

### 0.2.3

* Better 1.9 support
* Update parsing gems

### 0.2.2

* PostGIS support

### 0.2.1

* Bugfix for adapter-specific warnings
* Loosen parser dependencies

### 0.2.0

* Rails 3.1+ support
* Easier installation
* Ruby 1.9 fix
* travis-ci

## 0.1.x

### 0.1.14

* sqlite + ruby1.9 bugfix

### 0.1.13

* drop_trigger fix

### 0.1.12

* DB-specific trigger body support
* Misc bugfixes

### 0.1.11

* Safer migration loading
* Misc speedups

### 0.1.10

* Speed up migration evaluation

### 0.1.9

* MySQL fixes for inferred root@localhost

### 0.1.7

* Rails 3 support
* Fix a couple manual create_trigger bugs

### 0.1.6

* rake db:schema:dump support
* respect non-timestamped migrations

### 0.1.4

* Compatibility tracking
* Fix Postgres return bug
* Ensure last action has a semicolon

### 0.1.3

* Better error handling
* Postgres 8.x support
* Update docs

### 0.1.2

* Fix `Builder#security`
* Update docs

### 0.1.1

* Fix bug in `HairTrigger.migrations_current?`
* Fix up Gemfile

### 0.1.0

* Initial release
