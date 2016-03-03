RSpec.shared_examples 'a layer' do
  it 'responds to create' do
    is_expected.to respond_to(:create)
  end

  it 'responds to read_latest' do
    is_expected.to respond_to(:read_latest)
  end
end
