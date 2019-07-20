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
        # binding.pry
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
  cart.each do |item_name, attributes|
    discounted_cart[item_name] = attributes
    coupons.each do |coupon|
      # binding.pry
      if coupon[:item] == item_name
        if discounted_cart[item_name][:count] >= coupon[:num]
          discounted_cart[item_name][:count] -= coupon[:num]

          # checking if discounted item already in cart
          if discounted_cart["#{item_name} W/COUPON"] == nil
            discounted_cart["#{item_name} W/COUPON"] = {:price => (coupon[:cost]/coupon[:num]), :clearance => discounted_cart[item_name][:clearance] , :count => coupon[:num]}
          else
            discounted_cart["#{item_name} W/COUPON"][:count] += coupon[:num]
          end
        end
      end
    end
  end
  # binding.pry
  return discounted_cart
end

def apply_clearance(cart)
  # code here
  cart.each do |item, attributes|
    # binding.pry
    if attributes[:clearance] == true
      attributes[:price] *= 0.8
      attributes[:price] = attributes[:price].round(3)
      # binding.pry
    end
  end
  return cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  discounted_cart = apply_coupons(consolidated_cart, coupons)
  adjusted_cart = apply_clearance(discounted_cart)

  price = 0

  adjusted_cart.each do |item_name, attributes|
    # binding.pry
    price += attributes[:price]*attributes[:count]
  end

  if price > 100
    price *= 0.9
  end

  return price
end
