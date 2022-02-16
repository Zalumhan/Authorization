//
//  LoginViewModel.swift
//  SwiftClient
//
//  Created by Mohammad Azam on 4/14/21.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var isAuthenticated = false
    var username: String = ""
    var password: String = ""
    
    func login() {
        Webservice().login(username: username, password: password) { result in
            switch result {
            case .success(let token):
                UserDefaults.standard.setValue(token, forKey: "jsonwebtoken")
                Task { @MainActor in
                    self.isAuthenticated = true
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func signout() {
        UserDefaults.standard.removeObject(forKey: "jsonwebtoken")
         Task { @MainActor in
            self.isAuthenticated = false
             self.username = ""
             self.password = ""
        }
    }
}
