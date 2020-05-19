module RedisWebManager
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :authenticated?, if: :authenticate
    before_action :check_code
    helper_method :available_codes

    protected

    def authenticated?
      instance_exec(&authenticate)
    end

    def authenticate
      RedisWebManager.authenticate
    end

    def info
      @info ||= RedisWebManager::Info.new code: params[:code]
    end

    def connection
      @connection ||= RedisWebManager::Connection.new code: params[:code]
    end

    def action
      @action ||= RedisWebManager::Action.new code: params[:code]
    end

    def data
      @data ||= RedisWebManager::Data.new code: params[:code]
    end

    def available_codes
      @available_codes ||= RedisWebManager.redises.keys
    end

    def check_code
      return if available_codes.include?(params[:code].to_s.to_sym)

      redirect_to code: available_codes.first
    end
  end
end
