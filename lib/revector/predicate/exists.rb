# frozen_string_literal: true

class Revector
  module Exists
    def self.check!(item, iteratee)
      compare(Utility::TryFetchOrBlank[item, iteratee])
    end

    def self.compare(value, other = false)
      case value
      in [*] | String
        value.size.positive?.to_s == other.to_s
      else
        !!value.to_s == other.to_s
      end
    end
  end

  module NotExists
    def self.check!(item, iteratee)
      !Exists.check!(item, iteratee)
    end

    def self.compare(value, other = nil)
      !Exists.compare(value, other)
    end
  end
end
