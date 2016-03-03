require 'spec_helper'
require 'carcant/subscriber/stdout'
require 'carcant/subscriber/shared_examples'

RSpec.describe Carcant::Subscriber::Stdout do

  subject { described_class }

  it_behaves_like 'a subscriber'

  describe '.fired' do
    it 'prints red text to stdout' do
      expect { subject.fired('Foo was fired') }.to output("\e\[31mFoo was fired\e\[0m\n").to_stdout
    end
  end

  describe '.hired' do
    it 'prints green text to stdout' do
      expect { subject.hired('Foo was hired') }.to output("\e\[32mFoo was hired\e\[0m\n").to_stdout
    end
  end
end
