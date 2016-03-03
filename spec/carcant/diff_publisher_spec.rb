require 'spec_helper'
require 'carcant/diff_publisher'
require 'support/test_subscriber'
require 'carcant/hip_chat/user'

RSpec.describe Carcant::DiffPublisher do

  describe '.publish' do

    it 'broadcasts an event to all the subscribers' do
      subscriber = Support::TestSubscriber
      allow(subscriber).to receive_messages(hired: nil, fired: nil)
      described_class.subscribers << subscriber
      user_hired = instance_double(Carcant::HipChat::User, name: 'Foo Wut')
      user_fired = instance_double(Carcant::HipChat::User, name: 'Bar Lol')
      diff = {
        '+' => [user_hired],
        '-' => [user_fired],
      }

      described_class.publish(diff: diff)

      expect(subscriber).to have_received(:hired).with('Foo Wut has been hired!')
      expect(subscriber).to have_received(:fired).with('Bar Lol has been fired :(')

      described_class.subscribers.clear
    end
  end
end
