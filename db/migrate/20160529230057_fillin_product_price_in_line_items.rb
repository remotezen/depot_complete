class FillinProductPriceInLineItems < ActiveRecord::Migration
  def change
    LineItem.all.each do |line|
      line.price = line.product.price
      line.save!
    end
  end
end
