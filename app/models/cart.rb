class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy
  
  def add_product(product_id)
    current_item = line_items.find_by(product_id: product_id)
    if current_item
      current_item.quantity +=1
    else
      new_price = Product.find_by(product_id)
      current_item = line_items.build(product_id: product_id, price: new_price)
    end
    current_item
  end
  
  def total_price
    line_items.to_a.sum {|item| item.total_price}
  end

  def reduce_quantity_by_one(product_id)
    current_item = line_items.find_by(product_id: product_id)
    if current_item
      current_items.quantity -= 1
    else
      raise "no such product"
    end
    current_item
  end
end
