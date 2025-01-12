//
//  AuthManager.swift
//  cafeSip
//
//  Created by hyunMac on 1/9/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@Observable
//MARK: - User
class AuthManager {
    static let shared = AuthManager()
    var currentAuthUser: FirebaseAuth.User?
    var currentUser: User?
    
    func createUser(email: String, password: String, userName: String) async {
        print(email,password,userName)
        
        do {
            // firebase에 아이디생성
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            
            // 해당 아이디에 데이터 넣기 아이디도 생성해서 넣어주자
            currentAuthUser = result.user
            guard let userId = currentAuthUser?.uid else { return }
            
            await uploadUserData(userId: userId, email: email, userName: userName)
        } catch {
            print("Failed to create user")
        }
    }
    
    func uploadUserData(userId: String, email: String, userName: String) async {
        let user = User(id: userId, email: email, userName: userName)
        
        do {
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
        } catch {
            print("Failed to upload user data")
        }
    }
    
    func signIn(email: String, password: String) async {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            currentAuthUser = result.user
            
            await loadCurrentUserData()
        } catch {
            print("Failed to signIn")
        }
    }
    
    func loadCurrentUserData() async {
        guard let userId = currentAuthUser?.uid else { return }
        do {
            currentUser = try await Firestore.firestore().collection("users").document(userId).getDocument(as: User.self)
        } catch {
            print("Failed to load CurrentUserData")
        }
    }
}

// MARK: - Store
extension AuthManager {
    func addStoreDataToUserData(id: String, storeAddress: String, storeDetailAddress: String, storeName: String) async {
        guard let userId = currentAuthUser?.uid else { return }
        let userRef = Firestore.firestore().collection("users").document(userId)
        
        let storeId = UUID().uuidString
        let store = Store(id: storeId, name: storeName, address: storeAddress, detailAddress: storeDetailAddress)
        
        do {
            let encodedStore = try Firestore.Encoder().encode(store)
            try await userRef.updateData([
                "store": encodedStore
            ])
            print("storeData add success")
        } catch {
            print("Failed to add StoreData")
        }
        
    }
}
