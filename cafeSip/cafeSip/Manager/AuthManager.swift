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
    
    init() {
        loadSavedCurrentUserData()
    }
    
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
            StoreManager.shared.currentStore = nil
            
            clearLocalUserData()
            print("로그아웃 성공")
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

// 데이터 로컬 저장
extension AuthManager {
    func saveCurrentUserDataOnBackground() {
        guard let currentUser = currentUser else { return }
        do {
            let encodeUser = try JSONEncoder().encode(currentUser)
            UserDefaults.standard.set(encodeUser, forKey: "currentUser")
            print("currentUser 데이터 로컬 저장 성공")
        } catch {
            print("currentUser 데이터 로컬 저장 실패 \(error.localizedDescription)")
        }
    }
    
    func loadSavedCurrentUserData() {
        guard let userData = UserDefaults.standard.data(forKey: "currentUser") else { return }
        do {
            currentUser = try JSONDecoder().decode(User.self, from: userData)
            print("currentUser 데이터 로컬에서 불러오기 성공")
        } catch {
            print("currentUser 데이터 로컬에 없거나, 불러오기 실패")
        }
    }
    
    func clearLocalUserData() {
        UserDefaults.standard.removeObject(forKey: "currentUser")
        print("로컬에서 currentUser 데이터 삭제성공")
    }
}
