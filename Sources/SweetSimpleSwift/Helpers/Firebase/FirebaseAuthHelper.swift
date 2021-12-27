//
//  FirebaseAuthHelper.swift
//  
//
//  Created by Christopher Guirguis on 12/26/21.
//

#if os(iOS)
import SwiftUI
import FBSDKLoginKit
import Firebase
import CryptoKit
import AuthenticationServices

open class FirebaseAuthHelper: ObservableObject {
  static let shared = FirebaseAuthHelper(clearUserData: nil)
  
  init(clearUserData: (() -> ())? = nil){
    self.clearUserData = clearUserData
  }
  @Published var state: SignInState = .signedOut
  @Published var isLoggingIn = false
  var clearUserData: (() -> ())? = nil
  
  func setLoggingIn(_ bool: Bool){
    withAnimation {
      self.isLoggingIn = bool
    }
  }
  
  func facebookAuth() {
      let loginManager = LoginManager()
      if let presentingVC = UIApplication.shared.windows.first?.rootViewController{
          loginManager.logIn(permissions: ["public_profile", "email"], from: presentingVC) { [weak self] (result, error) in
              guard error == nil else {
                  return
              }
              
              if let result =  result {
                  let credential = FacebookAuthProvider.credential(withAccessToken: result.token?.tokenString ?? "")
                  self?.firebaseAuth(credentials: credential)
              }
          }
      }
  }
  
  func facebook_signOut() {
      let loginManager = LoginManager()
      
      loginManager.logOut()
      
      firebaseSignOut { _ in }
  }
}

extension FirebaseAuthHelper {
  func firebasePasswordSignup(email: String, password: String, firstName: String, lastName: String, completion: @escaping ((User?, Error?) -> ())){
      Auth.auth().createUser(withEmail: email, password: password) { authDataResults, error in
          guard let authDataResults = authDataResults, error == nil else {
              print(error?.localizedDescription as Any)
              completion(nil, error)
            
              return
          }
          
          
          self.state = .signedIn
          print("logged in as \(authDataResults.user.displayName ?? "(uid):\(authDataResults.user.uid)")")
          
          self.firebaseChangeName("\(firstName) \(lastName)", completion: {user, error in
              completion(authDataResults.user, error)
          })
          
      }
  }

  func firebasePasswordSignIn(email: String, password: String, completion: @escaping ((User?, Error?) -> ())){
      Auth.auth().signIn(withEmail: email, password: password) { authDataResults, error in
          guard let authDataResults = authDataResults, error == nil else {
              print(error?.localizedDescription as Any)
              completion(nil, error)
              return
          }
          
          self.state = .signedIn
          completion(authDataResults.user, error)
      }
  }
  func firebaseSignOut(completion: (Error?) -> ()){
      do {
          try Auth.auth().signOut()
          self.state = .signedOut
        self.clearUserData?()
          completion(nil)
      } catch {
          completion(NSError())
      }
      
  }
  
  func firebaseDeleteUser(completion: @escaping (Error?) -> ()){
      let user = Auth.auth().currentUser
      
      user?.delete { error in
          completion(error)
      }
  }
  
  func firebaseChangeName(_ displayName: String, completion: ((User?, Error?) -> ())?){
      guard let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() else {
          print("failed to update name")
          return
      }
      
      changeRequest.displayName = displayName
      changeRequest.commitChanges { error in
          if let error = error {
              print("there was an error updating name")
              print(error.localizedDescription)
          }
          if let completion = completion {
              completion(Auth.auth().currentUser, error)
          }
      }
  }
  
  func firebaseAuth(credentials: AuthCredential) {
      Auth.auth().signIn(with: credentials) { (authResult, error) in
          if let error = error {
              let authError = error as NSError
              print(authError)
          }
          
          if let user = authResult?.user {
              
              print(user.displayName as Any)
              self.state = .signedIn
          }
        
        self.setLoggingIn(false)
      }
  }
  enum SignInState {
      case signedIn
      case signedOut
  }
}

#endif
