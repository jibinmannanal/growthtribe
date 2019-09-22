
module HomeHelper
  module JSONHandler
    require 'json'

    def from_json
      hash = JSON.parse(DATA)
      recursive hash
    end

    # You might want to add an extra check to stop an infinite loop
    # Beware the data!
    def recursive hash
      return nil if hash.nil?
      return hash unless hash.respond_to? :fetch
      Item.new id: hash["id"], child: recursive(hash["child"])
    end
  end
end


class Item
  extend HomeHelper::JSONHandler

  def self.items
    @items ||= {}
  end


  def initialize(id:, child:nil)
    @parent = child
    @id = id
    self.class.items[@id] = self
  end

  attr_reader :child, :id

  def to_h
    h = {id: @id, child: (@parent && child.id) }
    h.reject{|k,v| v.nil? }
  end

  alias_method :to_hash,:to_h
end
