require 'spec_helper'
require 'support/test_layer'
require 'carcant/store/shared_examples'

RSpec.describe Support::TestLayer do
  it_behaves_like 'a store'
end
