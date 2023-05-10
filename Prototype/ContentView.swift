//
//  ContentView.swift
//  Prototype
//
//  Created by Hilla Hotakainen on 8.5.2023.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    
    var body: some View {
        NavigationStack{
            VStack {
                Text("Prototype").font(.largeTitle)
                NavigationLink {
                    allUsersView()
                } label: {
                    Label("All users", systemImage: "")
                }
                
                NavigationLink {
                    addNewUserView()
                } label: {
                    Label("Add new user", systemImage: "")
                }
                
                NavigationLink {
                    updateUserView()
                } label: {
                    Label("update user by ID", systemImage: "")
                }
                
                NavigationLink {
                    removeUserView()
                } label: {
                    Label("Remove user by ID", systemImage: "")
                }
                
            }
        }
    }
}
