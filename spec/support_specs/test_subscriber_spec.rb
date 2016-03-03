require 'spec_helper'
require 'support/test_subscriber'
require 'carcant/subscriber/shared_examples'

RSpec.describe Support::TestSubscriber do
  subject { described_class }

  it_behaves_like 'a subscriber'
end
