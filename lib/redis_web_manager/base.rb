# frozen_string_literal: true

module RedisWebManager
  class Base
    attr_accessor :code

    def initialize(options = {})
      options = options.with_indifferent_access

      self.code = options[:code].presence || RedisWebManager.redises.keys.first
    end

    private

    def redis
      @redis ||= RedisWebManager.redises[code.to_sym]
    end
  end
end
