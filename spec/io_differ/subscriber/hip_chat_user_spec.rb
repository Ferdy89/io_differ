require 'spec_helper'
require 'io_differ/subscriber/hip_chat_user'
require 'io_differ/subscriber/shared_examples'

RSpec.describe IoDiffer::Subscriber::HipChatUser do

  subject { described_class.new(token: 'token', user_id: 1234) }

  it_behaves_like 'a subscriber'

  describe '#fired' do
    it 'sends a message to a designated user on hipchat' do
      VCR.use_cassette('hipchat/send_fired') do
        subject.fired('Foo was fired')
      end

      expect(WebMock).to have_requested(:post, "#{IoDiffer::HipChat::API_ENDPOINT}/user/1234/message?auth_token=token")
        .with(body: JSON.dump('message' => 'Foo was fired', 'notify' => true))
    end
  end

  describe '#hired' do
    it 'sends a message to a designated user on hipchat' do
      VCR.use_cassette('hipchat/send_hired') do
        subject.hired('Foo was hired')
      end

      expect(WebMock).to have_requested(:post, "#{IoDiffer::HipChat::API_ENDPOINT}/user/1234/message?auth_token=token")
        .with(body: JSON.dump('message' => 'Foo was hired', 'notify' => true))
    end
  end
end
