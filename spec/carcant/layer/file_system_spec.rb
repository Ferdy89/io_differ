require 'spec_helper'
require 'carcant/layer/file_system'
require 'carcant/layer/shared_examples'
require 'tempfile'

RSpec.describe Carcant::Layer::FileSystem do

  subject { described_class.new(path: file.path) }

  let(:file) { Tempfile.new('carcant') }

  it_behaves_like 'a layer'

  describe '#create' do
    it 'appends to a JSON object in a file with the epoch timestamp as a key' do
      file.write(JSON.dump('foo' => 'bar'))
      file.close
      file.open

      subject.create(['a', 'b', 'c'])

      stored_contents = JSON.load(file.read)
      expect(stored_contents['foo']).to eql('bar')
      expect(stored_contents.values).to include(['a', 'b', 'c'])
    end
  end

  describe '#read_latest' do
    it 'fetches the entry with the largest epoch key' do
      file.write(JSON.dump('12345' => 'foo', '54321' => 'bar'))
      file.close

      expect(subject.read_latest).to eql('bar')
    end
  end
end
