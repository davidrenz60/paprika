module PaprikaApi
  module Middleware
    class JSONParsing < Faraday::Middleware
      def initialize(app)
        super(app)
        @app = app
      end

      def call(env)
        @app.call(env).on_complete do |response_env|
          parse_json(response_env)
        end
      end

      def parse_json(env)
        env[:raw_body] = env[:body]
        env[:body] = JSON.parse(env[:body])["result"] unless env[:body].empty?
      end
    end
  end
end