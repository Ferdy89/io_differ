require 'spec_helper'
require 'io_differ'

RSpec.describe IoDiffer do

  it 'fetches the list of users, runs a diff and outputs it to stdout with colors' do
    IoDiffer::DiffPublisher.subscribers << IoDiffer::Subscriber::Stdout
    hip_chat          = IoDiffer::HipChat.new(token: 'token')
    file              = Tempfile.new('io_differ')
    store             = IoDiffer::Store::FileSystem.new(path: file.path)
    persistance_layer = IoDiffer::PersistanceLayer.new(store: store)
    diff              = nil

    VCR.use_cassette('acceptance/basic') do
      original_list = hip_chat.users
      persistance_layer.write_user_list([{ 'id' => 2, 'name' => 'Buuuh' }])
      persistance_layer.write_user_list(original_list)
      diff = persistance_layer.read_latest.diff(hip_chat.users)
    end

    expected_output = <<-OUT
\e[32mInput: Bar Wut\e[0m
\e[31mOutput: Foo Lol\e[0m
OUT
    expect { IoDiffer::DiffPublisher.publish(diff: diff) }.to output(expected_output).to_stdout

    IoDiffer::DiffPublisher.subscribers.clear
  end
end
