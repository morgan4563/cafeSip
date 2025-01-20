//
//  PayModel.swift
//  cafeSip
//
//  Created by hyunMac on 1/20/25.
//

struct PayModel {
    private var balance: Int = 0
    private var userId: String = ""
    
    func getBalance() -> Int {
        return balance
    }
    mutating func setBalance(newBalance: Int) {
        self.balance = newBalance
    }
    
    func getUserId() -> String {
        return userId
    }
    mutating func setUserId(id: String) {
        self.userId = id
    }
}
