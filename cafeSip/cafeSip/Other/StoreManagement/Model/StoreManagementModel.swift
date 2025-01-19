//
//  StoreManagementModel.swift
//  cafeSip
//
//  Created by hyunMac on 1/20/25.
//

struct StoreManagementModel {
    private var newMenuName: String = ""
    private var newMenuDescription: String = ""
    private var newMenuPrice: String = ""
    private var orders: [Order] = []
    
    func getNewMenuName() -> String {
        return newMenuName
    }
    
    mutating func setNewMenuName(_ name: String) {
        newMenuName = name
    }
    
    func getNewMenuDescription() -> String {
        return newMenuDescription
    }
    
    mutating func setNewMenuDescription(_ description: String) {
        newMenuDescription = description
    }
    
    func getNewMenuPrice() -> String {
        return newMenuPrice
    }
    
    mutating func setNewMenuPrice(_ price: String) {
        newMenuPrice = price
    }
    
    func getOrders() -> [Order] {
        return orders
    }
    
    mutating func setOrders(_ newOrders: [Order]) {
        orders = newOrders
    }
    
    mutating func clearMenuFields() {
        newMenuName = ""
        newMenuDescription = ""
        newMenuPrice = ""
    }
}
