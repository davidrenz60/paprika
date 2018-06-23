module PaprikaApi
  module Middleware
    class Authentication < Faraday::Middleware
      def initialize(app)
        super(app)
        @app = app
      end

      def call(env)
        @app.call(env).on_complete do |response_env|
          if response_env.status == 401
            raise AuthenticationFailure, 'Authentication Failed. Please set valid paprika email and password environment variables.'
          end
        end
      end
    end
  end
end