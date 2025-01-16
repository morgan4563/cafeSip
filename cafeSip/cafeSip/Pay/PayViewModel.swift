//
//  PayViewModel.swift
//  cafeSip
//
//  Created by hyunMac on 1/16/25.
//
import SwiftUI
import FirebaseFirestore

@Observable
class PayViewModel {
    var balance = 0
    var userName = "samepleName"
    var userId = "sampleId"
    
    init() {
        if let currentUserData = AuthManager.shared.currentUser {
            self.userName = currentUserData.userName
            self.userId = currentUserData.id
            self.balance = currentUserData.balance
        }
    }
    
    func processPayment(price: String, ownerId: String) async {
        guard let price = Int(price) else {
            print("price Int변형실패")
            return
        }
        if self.balance > price {
            balance -= price
            updateBalance()
            await sendMoneyToStore(ownerId: ownerId, price: price)
            print("결제완료 남은 잔액 \(balance)")
        } else {
            print("잔액부족")
        }
    }
    
    func sendMoneyToStore(ownerId: String, price: Int) async {
        do {
            let owner = try await Firestore.firestore().collection("users").document(ownerId).getDocument(as: User.self)
            var ownerBalance = owner.balance + price
            print(owner.id)
            try await Firestore.firestore().collection("users").document(ownerId).updateData(
                ["balance": ownerBalance]
            )
        } catch {
            print("ownerBalnce 수정 실패")
        }
    }
    
    func chargePaymoney(amount: Int) {
        balance += amount
        updateBalance()
    }
    
    func updateBalance() {
        Firestore.firestore().collection("users").document(userId).updateData(
            ["balance" : balance]
        )
    }
    
    func getBalance() async {
        do {
            let user = try await Firestore.firestore().collection("users").document(userId).getDocument(as: User.self)
            balance = user.balance
        } catch {
            print("balanceData 수신 실패")
        }
    }
}
