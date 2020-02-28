//
//  Created by Vladimir on 1/13/20.
//  Copyright © 2020 epam. All rights reserved.
//

import Foundation

public protocol CartRestaurantData {
	var id: Int { get }
	var chainID: Int { get }
	var label: String { get }
	var minAmountOrder: Int { get }
	var deliveryFee: Double { get }
	var isOpen: Bool { get }
	var src: String { get }
}

public protocol CartView: AnyObject {
    func reloadCalculationsRows()
}

public protocol CartServiceHolder {
    var cartService: CartService { get }
}

public protocol CartService {
    
	var restaurant: CartRestaurantData? { get set }
	
    var view: CartView? { get set }
    
    var items: [Int: CartItem] { get }
    
    var cartTotal: Double { get }
    var tax: Double { get }
    var deliveryPrice: Double { get }
    var promoDiscount: Double { get }
    
    var subtotal: Double { get }
	
	var isValid: Bool { get }
    
    func addItem(validatedItemClosure: @escaping () -> CartItem?)
    func removeItem(item: CartItem)
    
	func reload()
}

public final class CartServiceImplementation: CartService {
	
	public var restaurant: CartRestaurantData?
	
    public weak var view: CartView?
    
    public var cartTotal: Double {
        return items.values.reduce(0.0) { (res, item: CartItem) -> Double in
            res + item.overallPrice * Double(item.count)
        }
    }
    
    public var tax: Double = 0.0
    
	public var deliveryPrice: Double {
		return Double(restaurant?.deliveryFee ?? 0)
	}
    
    public var promoDiscount: Double = 0.0
    
    public var subtotal: Double {
		return cartTotal + tax + deliveryPrice + promoDiscount
    }
	
	public var isValid: Bool {
		guard let restaurant = restaurant else {
			return false
		}
		return cartTotal > Double(restaurant.minAmountOrder)
	}

    public var items: [Int: CartItem] = [:]
    
	public func addItem(validatedItemClosure: @escaping () -> CartItem?) {
		guard let item = validatedItemClosure() else {
			return
		}
		if items[item.id] != nil {
			items[item.id]?.count += item.count
		} else {
        	items[item.id] = item
		}
    }
    
    public func removeItem(item: CartItem) {
        items.removeValue(forKey: item.id)
    }
	
	public func reload() {
		items.removeAll()
		restaurant = nil
	}
}
