# IO Differ

IO Differ helps you easily observe the flow of people in and out of a social
network and publish the result on different formats.

It's currently a very crappy POC but works with a basic use case: tracking
HipChat users, logging them to a local JSON file and publishing the results to
the standard output. Try the following script yourself:

```ruby
require 'io_differ'


# Get the token from your HipChat account. Needs to have "View Group" permissions
hip_chat_fetcher  = IoDiffer::HipChat.new(token: 'YOUR_HIPCHAT_TOKEN')

# Setup the file where the list of users will be stored
store             = IoDiffer::Store::FileSystem.new(path: File.join(__dir__, 'users.json'))
persistance_layer = IoDiffer::PersistanceLayer.new(store: store)

# Fetch the users before and after
previous = persistance_layer.read_latest
current  = hip_chat_fetcher.users

# Write the list of users for the next iteration
persistance_layer.write_user_list(current)

# Calculate the diff between before and after
diff = previous.diff(current)

# Publish the diff to stdout. You can easily build your own publisher and add it here!
IoDiffer::DiffPublisher.subscribers << IoDiffer::Subscriber::Stdout
IoDiffer::DiffPublisher.publish(diff: diff)
```

You can then easily run this recurrently with a cron job. If you're using RVM
this is close to what you'll need to add to your crontab to run it every minute:
```
* * * * * .rvm/wrappers/ruby-2.2.2/ruby -I io_differ/lib io_differ/script.rb
```
