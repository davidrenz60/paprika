module PaprikaApi
  module Middleware
    class StatusCheck < Faraday::Middleware

      def initialize(app)
        super(app)
        @app = app
      end

      def call(env)
        @app.call(env).on_complete do |response_env|
          raise RequestFailure, error_message(response_env) unless response_env.status == 200
        end
      end

      private

      def error_message(env)
        "Status #{env.status} #{env.reason_phrase}."
      end
    end
  end
end