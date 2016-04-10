require 'spec_helper'
require 'io_differ/subscriber/hip_chat_room'
require 'io_differ/subscriber/shared_examples'

RSpec.describe IoDiffer::Subscriber::HipChatRoom do

  subject { described_class.new(token: 'token', room: 'Da Room', from: 'GOD') }

  it_behaves_like 'a subscriber'

  describe '#fired' do
    it 'sends a red notification to a designated room on hipchat' do
      VCR.use_cassette('hipchat/send_room_fired') do
        subject.fired('Foo was fired')
      end

      expect(WebMock).to have_requested(:post, "#{IoDiffer::HipChat::API_ENDPOINT}/room/Da%20Room/notification?auth_token=token")
        .with(body: JSON.dump(message: 'Foo was fired', from: 'GOD', notify: true, color: 'red'))
    end
  end

  describe '#hired' do
    it 'sends a green notification to a designated room on hipchat' do
      VCR.use_cassette('hipchat/send_room_hired') do
        subject.hired('Foo was hired')
      end

      expect(WebMock).to have_requested(:post, "#{IoDiffer::HipChat::API_ENDPOINT}/room/Da%20Room/notification?auth_token=token")
        .with(body: JSON.dump(message: 'Foo was hired', from: 'GOD', notify: true, color: 'green'))
    end
  end
end
