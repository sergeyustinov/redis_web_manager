# frozen_string_literal: true

require 'redis_web_manager/engine'
require 'redis_web_manager/base'
require 'redis_web_manager/action'
require 'redis_web_manager/connection'
require 'redis_web_manager/info'
require 'redis_web_manager/data'
require 'redis'

module RedisWebManager
  mattr_accessor :redis, default: ::Redis.new
  mattr_accessor :redises, default: { default: redis }
  mattr_accessor :lifespan, default: 15.days
  mattr_accessor :authenticate, default: nil

  class << self
    def configure
      yield self if block_given?
      check_attrs
    end

    private

    def check_attrs
      redises.each do |code, r|
        unless r.is_a?(::Redis)
          raise ArgumentError, "Invalid Redis instance for #{code}, use like that Redis.new"
        end
      end
      unless lifespan.is_a?(::ActiveSupport::Duration)
        raise ArgumentError, 'Invalid lifespan, use like that 15.days, 15.minutes etc'
      end
      valid = lifespan.to_i.positive?
      raise ArgumentError, 'Invalid lifespan, value must be greater than 0' unless valid
    end
  end
end
