//
//  OrderModel.swift
//  cafeSip
//
//  Created by hyunMac on 1/20/25.
//

import Foundation

struct OrderModel {
    private var storeId: String = ""
    private var storeName: String = ""
    private var ownerId: String = ""
    private var menuItems: [MenuItem] = []
    private var selectedMenu: MenuItem?
    
    private var userId: String = ""
    private var userName: String = ""
    private var balance: Int = 0
    
    private var orderId: String = ""
    private var orderStatus: String = ""
    
    func getStoreId() -> String {
        return storeId
    }
    mutating func setStoreId(id: String) {
        storeId = id
    }
    
    func getStoreName() -> String {
        return storeName
    }
    mutating func setStoreName(name: String) {
        storeName = name
    }
    
    func getOwnerId() -> String {
        return ownerId
    }
    mutating func setOwnerId(id: String) {
        self.ownerId = id
    }
    
    func getMenuItems() -> [MenuItem] {
        return menuItems
    }
    mutating func setMenuItems(items: [MenuItem]) {
        self.menuItems = items
    }
    
    func getSelectedMenu() -> MenuItem? {
        return selectedMenu
    }
    mutating func setSelectedMenu(menu: MenuItem?) {
        self.selectedMenu = menu
    }
    
    func getUserId() -> String {
        return userId
    }
    mutating func setUserId(id: String) { self.userId = id
    }
    
    func getUserName() -> String {
        return userName
    }
    mutating func setUserName(name: String) { self.userName = name
    }
    
    func getBalance() -> Int {
        return balance
    }
    mutating func setBalance(balance: Int) {
        self.balance = balance
    }
    
    func getOrderId() -> String {
        return orderId
    }
    mutating func setOrderId(id: String) {
        self.orderId = id
    }
    
    func getOrderStatus() -> String {
        return orderStatus
    }
    mutating func setOrderStatus(status: String) {
        self.orderStatus = status
    }
    

    
    mutating func clear() {
        storeId = ""
        storeName = ""
        menuItems = []
        selectedMenu = nil
        balance = 0
        storeId = ""
        storeName = ""
//        orderId = ""
//        orderStatus = ""
    }
}
