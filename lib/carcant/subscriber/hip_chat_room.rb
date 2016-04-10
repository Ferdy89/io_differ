require 'carcant/hip_chat'
require 'erb'

module Carcant
  module Subscriber
    class HipChatRoom
      attr_reader :token, :room, :from

      def initialize(token: , room: , from: '')
        @token = token
        @room  = room
        @from  = from
      end

      def hired(text)
        send_message(text, 'green')
      end

      def fired(text)
        send_message(text, 'red')
      end

      private

      def send_message(text, color)
        query = URI.encode_www_form([['auth_token', token]])
        uri   = URI("#{Carcant::HipChat::API_ENDPOINT}/room/#{ERB::Util.url_encode(room)}/notification?#{query}")

        req                 = Net::HTTP::Post.new(uri)
        req['Content-Type'] = 'application/json'
        req.body            = JSON.dump({ message: text, from: from, notify: true, color: color })

        Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
          http.request(req)
        end
      end
    end
  end
end
