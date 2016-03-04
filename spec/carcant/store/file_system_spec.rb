require 'spec_helper'
require 'carcant/store/file_system'
require 'carcant/store/shared_examples'
require 'tempfile'

RSpec.describe Carcant::Store::FileSystem do

  subject { described_class.new(path: file.path) }

  let(:file) { Tempfile.new('carcant') }

  it_behaves_like 'a store'

  describe '#create' do
    it 'appends a JSON object to a file with a timestamp' do
      file.write(JSON.dump('foo' => 'bar'))
      file.write("\n")
      file.close
      file.open

      Timecop.freeze(Time.utc(2016, 3, 2, 20, 50, 1))
      subject.create([{ 'id' => '1' }, { 'id' => '2' }])

      stored_contents = file.readlines.map { |l| JSON.load(l) }
      expect(stored_contents).to eql([{ 'foo' => 'bar' }, { 'users' => [{ 'id' => '1' }, { 'id' => '2' }], 'timestamp' => 1456951801 }])
    end
  end

  describe '#read_latest' do
    it 'fetches the last entry' do
      subject.create('a' => 'a')
      subject.create('c' => 'c')
      subject.create('b' => 'b')

      expect(subject.read_latest).to eql('b' => 'b')
    end
  end
end
