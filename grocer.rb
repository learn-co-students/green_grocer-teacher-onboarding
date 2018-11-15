require 'pry'

def consolidate_cart(cart)
  consolidated = {}
  cart.each_with_object({}) do |items, item|
    items.each do |name, attributes|
      if item[name]
        attributes[:count] += 1
      else
        attributes[:count] = 1
        item[name] = attributes
      end
    end
  end
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:price => coupon[:cost], :count => 1}
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
      end
      cart[name][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, attributes|
    if attributes[:clearance] == true
      attributes[:price] *= 0.8
      attributes[:price] = attributes[:price].round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total_price = 0
  cart.each do |name, attributes|
    total_price += attributes[:price] * attributes[:count]
  end
  if total_price > 100
    total_price *= 0.9
    total_price = total_price.round(2)
  end
  total_price
end
