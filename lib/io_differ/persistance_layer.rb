require 'io_differ/user'
require 'io_differ/user_list'

module IoDiffer
  class PersistanceLayer
    attr_reader :store

    def initialize(store: )
      @store = store
    end

    def write_user_list(list)
      store.create(list.map(&:to_h))
    end

    def read_latest
      IoDiffer::UserList.new(
        store.read_latest.map do |row|
          IoDiffer::User.new(
            id:    row['id'],
            name:  row['name'],
          )
        end
      )
    end
  end
end
