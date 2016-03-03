require 'spec_helper'
require 'carcant'

RSpec.describe Carcant do

  it 'fetches the list of users, runs a diff and outputs it to stdout with colors' do
    Carcant::DiffPublisher.subscribers << Carcant::Subscriber::Stdout
    hip_chat = Carcant::HipChat.new(token: 'token')
    file     = Tempfile.new('carcant')
    layer    = Carcant::Layer::FileSystem.new(path: file.path)
    store    = Carcant::Store.new(layer: layer)
    diff     = nil

    VCR.use_cassette('acceptance/basic') do
      original_list = hip_chat.users
      store.write_user_list([{ 'id' => 2, 'name' => 'Buuuh', 'mention_name' => 'B' }])
      store.write_user_list(original_list)
      diff = store.read_latest.diff(hip_chat.users)
    end

    expected_output = <<-OUT
e[32mBar Wut has been hired!
e[31mFoo Lol has been fired :(
OUT
    expect { Carcant::DiffPublisher.publish(diff: diff) }.to output(expected_output).to_stdout
  end
end
