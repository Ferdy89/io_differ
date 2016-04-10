require 'spec_helper'
require 'io_differ/user_list'

RSpec.describe IoDiffer::UserList do

  subject { described_class.new(users) }

  let(:users) { [] }

  describe '#diff' do
    let(:user_foo)         { IoDiffer::User.new(id: 1, name: 'Lord Foo') }
    let(:user_foo_changed) { IoDiffer::User.new(id: 1, name: 'Foodor') }
    let(:user_bar)         { IoDiffer::User.new(id: 2, name: 'Mr Bar') }
    let(:user_baz)         { IoDiffer::User.new(id: 3, name: 'Don Baz') }

    let(:list_1) { described_class.new([user_foo, user_bar]) }
    let(:list_2) { described_class.new([user_baz, user_foo_changed]) }

    it 'calculates which users have appeared and which users have disappeared, keeping the ones with the same id' do
      diff = list_1.diff(list_2)

      expect(diff['+']).to contain_exactly(user_baz)
      expect(diff['-']).to contain_exactly(user_bar)
    end
  end
end
