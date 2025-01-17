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
        
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            
            currentAuthUser = result.user
            guard let userId = currentAuthUser?.uid else { return }
            
            await uploadUserData(userId: userId, email: email, userName: userName)
        } catch {
            print("Failed to create user")
        }
    }
    
    func uploadUserData(userId: String, email: String, userName: String) async {
        let user = User(id: userId, email: email, userName: userName, balance: 0)
        
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
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            currentAuthUser = nil
            currentUser = nil
        } catch {
            print("로그아웃 실패 \(error.localizedDescription)")
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

