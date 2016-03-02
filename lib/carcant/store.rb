require 'carcant/hip_chat/user'

module Carcant
  class Store
    attr_reader :layer

    def initialize(layer: )
      @layer = layer
    end

    def write_user_list(list)
      layer.create(list.map(&:to_h))
    end
  end
end
