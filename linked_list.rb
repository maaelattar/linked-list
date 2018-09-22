class Node
  attr_accessor :next_node
  attr_reader :value
  def initialize(value, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

class LinkedList
  def initialize
    @head = nil
  end

  def append(value)
    node = Node.new(value)
    if @head.nil?
      @head = node
    else
      tail.next_node = node
    end
  end

  def prepend(value)
    node = @head
    @head = Node.new(value)
    @head.next_node = node
  end

  def size
    counter = 0
    nodes { counter += 1 }
    counter
  end

  attr_reader :head

  def tail
    nodes { |node| node }
  end

  def at(index)
    index += size if index < 0
    counter = 0
    nodes { |node| return node if counter == index; counter += 1 }
  end

  def pop
    node = tail
    at(-2).next_node = nil
    node
  end

  def contains?(value)
    nodes { |node| return true if node.value == value }
  end

  def find(data)
    counter = 0
    nodes { |node| return counter if node.value == data; counter += 1 }
  end

  def to_s
    string = ''
    nodes { |node| string += "( #{node.value} ) -> " }
    string << 'nil'
  end

  def insert_at(index, value)
    node = Node.new(value, at(index))
    append(node) if index > size
    index.zero? ? @head = node : at(index - 1).next_node = node
  end

  def remove_at(index)
    return if index > size
    return @head = at(1) if index.zero?
    at(index - 1).next_node = if index + 1 == size
                                nil
                              else
                                at(index + 1)
                              end
  end

  def nodes(node = @head)
    until node.nil?
      result = yield(node)
      node = node.next_node
    end
    result
  end
end
