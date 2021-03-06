require 'io_differ/hip_chat'

module IoDiffer
  module Subscriber
    class HipChatUser
      attr_reader :token, :user_id

      def initialize(token: , user_id: )
        @token   = token
        @user_id = user_id
      end

      def hired(text)
        send_message(text)
      end

      def fired(text)
        send_message(text)
      end

      private

      def send_message(text)
        query = URI.encode_www_form([['auth_token', token]])
        uri   = URI("#{IoDiffer::HipChat::API_ENDPOINT}/user/#{user_id}/message?#{query}")

        req                 = Net::HTTP::Post.new(uri)
        req['Content-Type'] = 'application/json'
        req.body            = JSON.dump({ message: text, notify: true })

        Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(req)
        end
      end
    end
  end
end
