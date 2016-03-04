require 'spec_helper'
require 'carcant/persistance_layer'
require 'support/test_store'

RSpec.describe Carcant::PersistanceLayer do

  subject { described_class.new(store: store) }

  let(:store) { Support::TestStore.new }
  let(:user)  { Carcant::HipChat::User.new(id: 1, name: 'FooBar') }

  describe '#write_user_list' do
    it 'takes a list of HipChat::Users and sends it to the store as a hash' do
      list = [user]
      allow(store).to receive(:create)

      subject.write_user_list(list)

      expect(store).to have_received(:create).with([{ id: 1, name: 'FooBar' }])
    end
  end

  describe '#read_latest' do
    it 'fetches the latest list of users from the store and returns a HipChat::UserList' do
      allow(store).to receive(:read_latest).and_return([{ 'id' => 1, 'name' => 'FooBar' }])

      result = subject.read_latest

      expect(result).to be_kind_of(Carcant::HipChat::UserList)
      expect(result).to satisfy('contains the user from the store') do |users|
        users.any? { |u| u.id == 1 && u.name == 'FooBar' }
      end
    end
  end
end
