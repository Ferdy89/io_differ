require 'carcant/user'

module Carcant
  class UserList
    include Enumerable

    attr_reader :users

    def initialize(users)
      @users = users
    end

    def each(&block)
      users.each(&block)
    end

    def diff(other)
      {
        '+' => self.class.new(new_users_in(other)),
        '-' => self.class.new(other.new_users_in(self)),
      }
    end

    protected

    def new_users_in(other_list)
      other_list.users.reject do |other_user|
        users.find { |u| u.id == other_user.id }
      end
    end
  end
end
