<p align="center">
  <h1 align="center">🔃 revector</h1>
  <p align="center"><i>Simple wrapper to filter array using Ruby and simple predicate conditions</i></p>
</p>

<p align="center">
  <a href="https://rubygems.org/gems/revector" style="text-decoration: none !important;">
    <img alt="Gem" src="https://img.shields.io/gem/v/revector.svg">    
  </a>

  <a href="https://github.com/thadeu/revector/actions/workflows/ci.yml" style="text-decoration: none !important;">
    <img alt="Build Status" src="https://github.com/thadeu/revector/actions/workflows/ci.yml/badge.svg">
  </a>
</p>


## Motivation

Because in sometimes, we need filter array passing conditions. This gem simplify this work.

## Documentation <!-- omit in toc -->

Version    | Documentation
---------- | -------------
unreleased | https://github.com/thadeu/revector/blob/main/README.md

## Table of Contents <!-- omit in toc -->
  - [Installation](#installation)
  - [Configuration](#configuration)
  - [Availables Predicates](#availables-predicates)
  - [Usage](#usage)
  - [Utilities](#utilities)

## Compatibility

| kind           | branch  | ruby               |
| -------------- | ------- | ------------------ |
| unreleased     | main    | >= 2.7 |

## Installation

Use bundle

```ruby
bundle add revector
```

or add this line to your application's Gemfile.

```ruby
gem 'revector'
```

and then, require module

```ruby
require 'revector'
```

## Configuration

Without configuration, because we use only Ruby. ❤️

## Availables Predicates for all values

| Type | Suffix | Value | 
| ----------- | ----------- | ----------- |
| Equal | eq      | Anywhere |
| NotEqual | noteq        | Anywhere |
| Contains | cont        | Anywhere |
| NotContains | notcont        | Anywhere |
| Included | in  | Anywhere |
| NotIncluded | notin        | Anywhere |
| Start | start        | Anywhere |
| NotStart | notstart        | Anywhere |
| End | end        | Anywhere |
| NotEnd | notend        | Anywhere |
| LessThan | lt        | Anywhere |
| LessThanEqual | lteq        | Anywhere |
| GreaterThan | gt        | Anywhere |
| GreaterThanEqual | gteq        | Anywhere |

## Availables Predicates only when value is Hash

> 💡 Below predicates works only when value is Hash

| Type | Suffix | Value | 
| ----------- | ----------- | ----------- |
| NotEqual | not_eq        | Hash |
| NotContains | not_cont        | Hash |
| NotIncluded | not_in        | Hash |
| NotStart | not_start        | Hash |
| NotEnd | not_end        | Hash |


## Usage

<details>
  <summary>Think that your data seems like this.</summary>
  
  ```ruby
  data = [
    {
      id: 1,
      name: 'Test #1',
      email: 'test1@email1.com',
      schedule: { all_day: true },
      numbers: %w[1 2],
      active: true,
      count: 9
    },
    {
      id: 2,
      name: 'Test #2',
      email: 'test2@email2.com',
      schedule: { all_day: false },
      numbers: %w[3 4],
      active: true,
      count: 10
    },
    {
      id: 3,
      name: 'Test #3',
      email: 'test3@email3.com',
      schedule: { all_day: false },
      numbers: %w[5 6],
      active: false,
      count: 99
    }
  ]
  ```
</details>

You can use one or multiples predicates in your filter. We see some use cases.

### Flexible Use Case (Hash)

**Equal**

```ruby
filters = {
  active: {
    eq: true
  }
}

collection = Revector.swap(data, filters)
```

**NotEqual**

```ruby
filters = {
  active: {
    # noteq or not_eq
    not_eq: true
  }
}

collection = Revector.swap(data, filters)
```

**Nested Hash Paths**

```ruby
filters = {
  'schedule.all_day': {
    eq: true
  }
}

collection = Revector.swap(data, filters)
```

**Nested Array Paths**

> Note the `.0` 🎉

```ruby
filters = {
  'numbers.0': {
    eq: '3'
  }
}

collection = Revector.swap(data, filters)
```

```ruby
filters = {
  numbers: {
    in: '3' # or in: ['3']
  }
}

collection = Revector.swap(data, filters)
```

Using default Equal predicate.

```ruby
Revector.swap(data, numbers: 3)

Revector.swap(data, active: true)

Revector.swap(data, id: 3)
```

If array, you can navigate into self, using `property.NUMBER.property`

```ruby
data = [
  {
    schedules: [
      {
        opened: true,
        all_day: true
      },
      {
        opened: false,
        all_day: true
      }
    ]
  },
  {
    schedules: [
      {
        opened: false,
        all_day: true
      },
      {
        opened: false,
        all_day: true
      }
    ]
  }
]

filters = {
  'schedules.0.opened': {
    eq: true
  }
}

# OR

filters = {
  'schedules[0]opened': {
    eq: true
  }
}

# OR

filters = {
  'schedules.[0].opened': {
    eq: true
  }
}

collection = Revector.swap(data, filters)

# [{ schedules: [{ opened: true, all_day: true }, { opened: false, all_day: true }] }]
```

Amazing, you can pass a Callable value as value, like this.

```ruby
filters = {
  'schedules.[0].opened': {
    eq: -> { true }
  }
}

# OR a Module

module ActiveTruthy
  def self.call = true
end

module NumbersAvailable
  def self.call = %w[1 2]
end

filters = {
  'schedules.[0].opened': {
    eq: ActiveTruthy
  },
  numbers: {
    in: NumbersAvailable
  }
}

# OR a Class

class ActiveFalsey
  def self.call = false
end

filters = {
  'schedules.[0].opened': {
    eq: ActiveFalsey
  }
}

collection = Revector.swap(data, filters)
```

**Combine conditions**

Yes, you can combine one or multiple predicates to filter you array.


```ruby
filters = {
  active: { eq: true },
  numbers: {
    in: %w[5],
    not_in: '10'
  },
  email: {
    cont: 'email1',
    not_cont: '@gmail'
  },
  'schedule.all_day': {
    in: [true, false]
  }
}

collection = Revector.swap(data, filters)
```

### Querystring Use Case

**Equal**

```ruby
filters = { active_eq: true }

collection = Revector.swap(data, filters)
```

**NotEqual**

```ruby
filters = { active_noteq: true }

collection = Revector.swap(data, filters)
```

**Nested Hash Paths**

```ruby
filters = { 'schedule.all_day_eq': false }

collection = Revector.swap(data, filters)
```

**Nested Array Paths**

> Note the `.0` 🎉

```ruby
filters = { 'numbers.0_eq': '3' }

collection = Revector.swap(data, filters)
```

```ruby
filters = { numbers_in: ['1'] }

collection = Revector.swap(data, filters)

expect(collection.size).to eq(1)
```

**Combine conditions**

Yes, you can combine one or multiple predicates to filter you array.


```ruby
filters = {
  active_noteq: true,
  numbers_in: %w[5],
  email_cont: 'test3',
  'schedule.all_day_eq': false
}

collection = Revector.swap(data, filters)
```

**Receive querystring in your route**

Like Ransack, imagine that you receive an querystring and you want to filter your Array. So, you can to do something like this.

> ⚠️ But security is your responsability, ok? Let's go!

```ruby
# receive querystring in your route
querystring = "active_noteq=true&numbers_in=5&email_cont=test3&schedule.all_day_eq=false"

# parse querystring and transform to Hash
params = URI.decode_www_form(querystring).to_h

# filter your collection using params directly.
collection = Revector.swap(data, filters)

# Beautiful, right? 🎉
```

[⬆️ &nbsp;Back to Top](#table-of-contents-)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/thadeu/revector. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/thadeu/revector/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
