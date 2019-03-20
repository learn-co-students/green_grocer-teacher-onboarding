def consolidate_cart(cart)
  new_cart = Hash.new
  cart.each do |item|
    item_name = item.keys[0]
    if new_cart.has_key?(item_name) 
      new_cart[item_name][:count] += 1 
    else
      new_cart[item_name] = item[item_name]
      new_cart[item_name][:count] = 1 
    end
  end
  new_cart
end



def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item_name = coupon[:item]
    if cart[item_name]
      coupon_name = item_name + " W/COUPON"
      unless cart[coupon_name]
        cart[coupon_name] = Hash.new 
        cart[coupon_name][:price] = coupon[:cost]
        cart[coupon_name][:count] = 0
        cart[coupon_name][:clearance] = cart[item_name][:clearance]
      end
      while cart[item_name][:count] >= coupon[:num]
        cart[item_name][:count] -= coupon[:num]
        cart[coupon_name][:count] += 1
      end
    end
  end
  cart
  
end

def apply_clearance(cart)
  cart.each_value do |value|
    value[:price] -= value[:price] * 0.2 if value[:clearance]
  end
  cart
end

def checkout(cart, coupons)
  final_cart = consolidate_cart(cart)
  final_cart = apply_coupons(final_cart,coupons)
  final_cart = apply_clearance(final_cart)
  total = 0
  final_cart.each_value do |item|
    total += (item[:price] * item[:count]) if item[:count] > 0
  end
  total -= total * 0.1 if total > 100 
  total
  
end
