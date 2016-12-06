require 'minitest/autorun'
require 'minitest/pride'
require './lib/linked_list'

class LinkedListTest < Minitest::Test
  def test_linked_list_exists
    list = LinkedList.new
    assert_equal LinkedList, list.class
  end

  def test_list_has_head
    list = LinkedList.new
    assert_equal nil, list.head
  end

  def test_can_append_to_list
    list = LinkedList.new
    assert_equal "doop", list.append("doop")
    # require "pry"; binding.pry
    assert_equal "doop", list.head.data
    assert_equal nil, list.head.next_node
    assert_equal 1, list.count
    assert_equal "doop", list.to_string

    list.append("deep")
    assert_equal "deep", list.head.next_node.data
  end

end

# > require "./lib/linked_list"
# > list = LinkedList.new
# => <LinkedList head=nil #45678904567>
# > list.head
# => nil
# > list.append("doop")
# => "doop"
# > list
# => <LinkedList head=<Node data="doop" next_node=nil #5678904567890> #45678904567>
# > list.head.next_node
# => nil
# > list.count
# => 1
# > list.to_string
# => "doop"
