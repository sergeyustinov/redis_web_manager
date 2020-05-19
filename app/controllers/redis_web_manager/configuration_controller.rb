# frozen_string_literal: true

module RedisWebManager
  class ConfigurationController < RedisWebManager::ApplicationController
    # GET /configuration
    def index
      @configurations = info.configuration
      @status = info.status
      @url = connection.id
    end
  end
end
