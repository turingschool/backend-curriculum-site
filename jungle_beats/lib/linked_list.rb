require './lib/node'

class LinkedList
  attr_accessor :head
  def initialize
    @head = nil

  end

  def append(data)
    if head.empty?
      @head = Node.new(data)
      current_node = head
    else
    find_tail
    if current_node.next_node == nil
      # current_node = head
      # require "pry"; binding.pry
      current_node.next_node = Node.new(data)
      current_node = current_node.next_node
      require "pry"; binding.pry
    end
    # append(data)
  end

  def count
    1
  end

  def to_string
    head.data
  end
end
