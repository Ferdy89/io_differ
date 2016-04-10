require 'spec_helper'
require 'io_differ/hip_chat'

RSpec.describe IoDiffer::HipChat do

  subject { described_class.new(token: 'token') }

  describe '#users' do
    it 'fetches a list of users from HipChat with id and name' do
      VCR.use_cassette('hipchat/pull_users') do
        expect(subject.users).to satisfy('has user with id 1 named FooBar with mention @Foo') do |users|
          users.any? { |u| u.id == 1 && u.name == 'FooBar' }
        end
      end
    end
  end
end
