module PaprikaApi
  class Error < StandardError; end
  class AuthenticationFailure < Error; end
  class RequestFailure < Error; end

  class Client
    BASE_URL = "https://www.paprikaapp.com/api/v1/sync/".freeze

    def initialize(email, password)
      @email = email
      @password = password
    end

    def recipes_data
      response = connection.get "recipes/"
      data = response.body

      # create a 'token' key, since 'hash' is reserved
      data.each { |recipe| recipe["token"] = recipe["hash"] }
      data
    end

    def recipes
      recipes_data.map { |data| recipe(data["uid"]) }
    end

    def recipe(id)
      response = connection.get "recipe/#{id}/"
      recipe = response.body
      recipe["token"] = recipe["hash"]
      recipe
    end

    def categories
      response = connection.get "categories/"
      response.body
    end

    private

    def connection
      options = {
        url: BASE_URL
      }

      @connection ||= Faraday.new(options) do |conn|
        conn.basic_auth(@email, @password)
        conn.use Middleware::JSONParsing
        conn.use Middleware::StatusCheck
        conn.use Middleware::Authentication
        conn.adapter Faraday.default_adapter
      end
    end
  end
end