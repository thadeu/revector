# frozen_string_literal: true

class Revector
  module Equal
    def self.check!(item, iteratee, expected_value)
      compare(expected_value, Utility::TryFetchOrBlank[item, iteratee])
    end

    def self.compare(value, expected_value)
      value == expected_value
    end
  end

  module NotEqual
    def self.check!(item, iteratee, value)
      !Equal.check!(item, iteratee, value)
    end

    def self.compare(value, expected_value)
      !Exists.compare(value) && !Equal.compare(value, expected_value)
    end
  end
end
