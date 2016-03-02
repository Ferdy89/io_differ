require 'spec_helper'
require 'carcant/hip_chat'

RSpec.describe Carcant::HipChat do

  subject { described_class.new(token: 'token') }

  describe '#users' do
    it 'fetches a list of users from HipChat with id, mention_name and name' do
      VCR.use_cassette('hipchat/pull_users') do
        expect(subject.users).to satisfy('has user with id 1 named FooBar with mention @Foo') do |users|
          users.any? do |user|
            user.id           == 1 &&
            user.name         == 'FooBar' &&
            user.mention_name == 'Foo'
          end
        end
      end
    end
  end
end
