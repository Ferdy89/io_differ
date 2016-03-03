require 'spec_helper'
require 'carcant/store'
require 'support/test_layer'

RSpec.describe Carcant::Store do

  subject { described_class.new(layer: layer) }

  let(:layer) { Support::TestLayer.new }
  let(:user)  { Carcant::HipChat::User.new(id: 1, name: 'FooBar', mention_name: 'Foo') }

  describe '#write_user_list' do
    it 'takes a list of HipChat::Users and sends it to the layer as a hash' do
      list = [user]
      allow(layer).to receive(:create)

      subject.write_user_list(list)

      expect(layer).to have_received(:create).with([{ 'id' => 1, 'name' => 'FooBar', 'mention_name' => 'Foo' }])
    end
  end

  describe '#read_latest' do
    it 'fetches the latest list of users from the layer and returns a HipChat::UserList' do
      allow(layer).to receive(:read_latest).and_return([{ 'id' => 1, 'name' => 'FooBar', 'mention_name' => 'Foo' }])

      result = subject.read_latest

      expect(result).to be_kind_of(Carcant::HipChat::UserList)
      expect(result).to satisfy('contains the user from the layer') do |users|
        users.any? do |user|
          user.id           == 1 &&
          user.name         == 'FooBar' &&
          user.mention_name == 'Foo'
        end
      end
    end
  end
end
