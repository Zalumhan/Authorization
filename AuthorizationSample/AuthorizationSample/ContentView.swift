//
//  ContentView.swift
//  SwiftClient
//
//  Created by Mohammad Azam on 4/13/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var loginVM = LoginViewModel()
    @StateObject private var accountListVM = AccountListViewModel()
    
    var body: some View {
        NavigationView {
            if loginVM.isAuthenticated {
                List(accountListVM.accounts, id: \.id) { account in
                    HStack {
                        Text("\(account.name)")
                        Spacer()
                    }
                }
                .toolbar {
                    Button("Signout") {
                        loginVM.signout()
                    }
                }
            } else {
                Form {
                    TextField("Username", text: $loginVM.username)
                    SecureField("Password", text: $loginVM.password)
                    HStack {
                        Spacer()
                        Button("Login") {
                            loginVM.login()
                            accountListVM.getAllAccounts()
                        }
                    }
                }
                .navigationTitle("Authorization")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
