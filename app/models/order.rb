class Order < ApplicationRecord  
  belongs_to :user
  has_many :orders_items
  has_many :items, through: :orders_items

  enum status: %w(ordered paid cancelled completed)

  def total_price
    orders_items.reduce(0) do |sum, item|
      sum += (item.current_price_per_unit * item.quantity.to_f)
      sum
    end
  end

  def item_quantity(item)
    orders_items.where(item_id: item.id).count
  end
end