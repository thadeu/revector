# frozen_string_literal: true

class Revector
  module Contains
    def self.check!(item, iteratee, value)
      fetched_value = Utility::TryFetchOrBlank[item, iteratee]
      return false unless fetched_value

      compare(fetched_value, value)
    end

    def self.compare(fetched_value, value)
      Array(value).any? { |v| fetched_value.to_s.match(/#{v}/) }
    end
  end

  module NotContains
    def self.check!(item, iteratee, value)
      !Contains.check!(item, iteratee, value)
    end

    def self.compare(fetched_value, value)
      !Contains.compare(fetched_value, value)
    end
  end
end
