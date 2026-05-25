require_relative "../repository/cart"

class CartService

  def self.add_to_cart(product_id,quantity)
    Cart.add_to_cart(product_id,quantity)
  end

  def self.open_cart
    Cart.open_cart
  end

  def self.remove_from_cart(product_id)
    Cart.remove_from_cart(product_id)
  end
end
