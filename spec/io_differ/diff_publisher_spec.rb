require 'spec_helper'
require 'io_differ/diff_publisher'
require 'support/test_subscriber'
require 'io_differ/user'

RSpec.describe IoDiffer::DiffPublisher do

  describe '.publish' do

    it 'broadcasts an event to all the subscribers' do
      subscriber = Support::TestSubscriber
      allow(subscriber).to receive_messages(hired: nil, fired: nil)
      described_class.subscribers << subscriber
      user_hired = instance_double(IoDiffer::User, name: 'Foo Wut')
      user_fired = instance_double(IoDiffer::User, name: 'Bar Lol')
      diff = {
        '+' => [user_hired],
        '-' => [user_fired],
      }

      described_class.publish(diff: diff)

      expect(subscriber).to have_received(:hired).with('Input: Foo Wut')
      expect(subscriber).to have_received(:fired).with('Output: Bar Lol')

      described_class.subscribers.clear
    end
  end
end
