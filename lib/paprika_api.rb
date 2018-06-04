class PaprikaApiClient
  BASE_URL = "https://www.paprikaapp.com/api/v1/sync/".freeze

  def initialize(email, password)
    @email = email
    @password = password
  end

  def recipes_data
    response = connection.get "recipes/"
    response = JSON.parse(response.body)["result"]
    # create a 'token' key, since 'hash' is reserved
    response.each { |recipe| recipe["token"] = recipe["hash"] }
    response
  end

  def recipes_index
    recipes_data.map { |data| recipe(data["uid"]) }
  end

  def recipe(id)
    response = connection.get "recipe/#{id}/"
    response = JSON.parse(response.body)["result"]
    response["token"] = response["hash"]
    response
  end

  def categories
    response = connection.get "categories/"
    response = JSON.parse(response.body)["result"]
    response
  end

  private

  def connection
    options = {
      url: BASE_URL
    }

    @connection ||= Faraday.new(options) do |conn|
      conn.basic_auth(@email, @password)
      conn.adapter Faraday.default_adapter
    end
  end
end