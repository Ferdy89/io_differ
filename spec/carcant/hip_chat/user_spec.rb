require 'spec_helper'
require 'carcant/hip_chat/user'

RSpec.describe Carcant::HipChat::User do

  subject { described_class.new(id: 1, name: 'FooBar') }

  describe '#to_h' do
    it 'turns the object into a plain hash' do
      expect(subject.to_h).to eql(id: 1, name: 'FooBar')
    end
  end
end
