require 'minitest/autorun'
require 'minitest/pride'
require './lib/node'

class NodeTest < Minitest::Test
  def test_node_class_exists
    node = Node.new("plop")
    assert_equal Node, node.class

  end

  def test_node_has_data
    node = Node.new("plop")
    assert_equal "plop", node.data
  end

  def test_next_node_is_nil
    node = Node.new("plop")
    assert_equal nil, node.next_node
  end

end


# > require "./lib/node"
# > node = Node.new("plop")
# > node.data
# => "plop"
# > node.next_node
# => nil
