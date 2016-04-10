require 'spec_helper'
require 'support/test_store'
require 'io_differ/store/shared_examples'

RSpec.describe Support::TestStore do
  it_behaves_like 'a store'
end
