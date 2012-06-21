class Person
  def full_name
    "Bob Smith"
  end

  def age
    43
  end

  def plus_one(val)
    val + 1
  end

  def takes_block(&block)
    block.call
  end
end
