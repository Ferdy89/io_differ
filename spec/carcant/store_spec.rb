require 'spec_helper'
require 'carcant/store'
require 'support/test_layer'

RSpec.describe Carcant::Store do

  subject { described_class.new(layer: layer) }

  let(:layer) { Support::TestLayer.new }

  describe '#write_user_list' do
    it 'takes a list of HipChat::Users and sends it to the layer as a hash' do
      list = [Carcant::HipChat::User.new(id: 1, name: 'FooBar', mention_name: 'Foo')]
      allow(layer).to receive(:create)

      subject.write_user_list(list)

      expect(layer).to have_received(:create).with([{ 'id' => 1, 'name' => 'FooBar', 'mention_name' => 'Foo' }])
    end
  end
end
