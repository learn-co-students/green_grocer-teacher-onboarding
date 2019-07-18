require "pry"

def consolidate_cart(cart)
  # code here
  # binding.pry
  consolidated_cart_hash = {}
  current_item = {}
  cart.each do |item|
    item.each do |name, attributes|
      # binding.pry
      if current_item == item
        consolidated_cart_hash[name][:count] += 1
      else
        consolidated_cart_hash[name] = attributes
        consolidated_cart_hash[name][:count] = 1
      end
      current_item = item
    end
  end
  # binding.pry
  return consolidated_cart_hash
end

def apply_coupons(cart, coupons)
  # code here
  discounted_cart = {}
  current_item = {}
  cart.each do |name, attributes|
    discounted_cart[name] = attributes
    coupons.each do |hash|
      # binding.pry
      if hash[:item] == name
        coupon_multiple = discounted_cart[name][:count] / hash[:num]
        number_discounted = coupon_multiple * hash[:num]
        discounted_cart[name][:count] -= number_discounted
        discounted_cart["#{name} W/COUPON"] = {:price => (hash[:cost]/hash[:num]), :clearance => discounted_cart[name][:clearance] , :count => number_discounted}
      end
    end
  end
  # binding.pry
  return discounted_cart
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
