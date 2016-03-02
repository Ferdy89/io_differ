RSpec.shared_examples 'a subscriber' do
  it 'responds to fired' do
    is_expected.to respond_to(:fired)
  end

  it 'responds to hired' do
    is_expected.to respond_to(:hired)
  end
end
