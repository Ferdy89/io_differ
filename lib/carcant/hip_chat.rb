require 'net/http'
require 'json'
require 'carcant/hip_chat/user_list'
require 'carcant/hip_chat/user'

module Carcant
  class HipChat
    API_ENDPOINT = 'https://api.hipchat.com/v2'

    attr_reader :token, :max_results

    def initialize(token: )
      @token       = token
      @max_results = 1000
    end

    def users
      Carcant::HipChat::UserList.new(
        raw_users_data.map do |raw_user_data|
          Carcant::HipChat::User.new(
            id:            raw_user_data['id'],
            mention_name:  raw_user_data['mention_name'],
            name:          raw_user_data['name']
          )
        end
      )
    end

    private

    def raw_users_data
      query    = URI.encode_www_form([['auth_token', token], ['max-results', max_results]])
      endpoint = URI("#{API_ENDPOINT}/user?#{query}")
      response = Net::HTTP.get(endpoint)

      JSON.load(response)['items']
    end
  end
end
