require 'net/http'
require 'json'
require 'uri'

class HubspotClient
  API_KEY = '461455c2df02ab37b71a03fe0569'.freeze
  BASE_URL = 'https://candidate.hubteam.com/candidateTest/v3/problem'.freeze

  def initialize
    @dataset_url = "#{BASE_URL}/dataset?userKey=#{API_KEY}"
    @result_url = "#{BASE_URL}/result?userKey=#{API_KEY}"
  end

  def fetch_dataset
    uri = URI(@dataset_url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  def post_results(results)
    uri = URI(@result_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
    request.body = { 'results' => results }.to_json

    response = http.request(request)
    JSON.parse(response.body)
  end
end
