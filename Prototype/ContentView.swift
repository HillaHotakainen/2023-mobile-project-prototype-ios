//
//  ContentView.swift
//  Prototype
//
//  Created by Hilla Hotakainen on 8.5.2023.
//

import SwiftUI
import Alamofire

struct HttpResult: Codable {
    let users : [Person]
}

struct Person: Codable {
    let firstName: String
    let lastName: String
    let id : Int
}

struct NewUser: Encodable {
    let firstName: String
    let lastName: String
}

struct ContentView: View {
    @State var people : Array<Person>? = nil
    
    var body: some View {
        NavigationStack{
            VStack {
                Text("Prototype").font(.largeTitle)
                Button("Fetch all users") {
                    AF.request("https://dummyjson.com/users/")
                        .responseDecodable(of: HttpResult.self) { response in
                        if let result = response.value {
                            self.people = result.users
                        }
                    }
                } .padding(2)
                NavigationLink {
                    allUsersView(people: people)
                } label: {
                    Label("All users", systemImage: "")
                }
                .navigationTitle("Prototype")
                
                NavigationLink {
                    addNewUserView()
                } label: {
                    Label("Add new user", systemImage: "")
                }
            }
        }
    }
}
struct allUsersView: View {
    let people: [Person]?
    var body: some View {
        if(people != nil){
            List {
                ForEach(people!, id: \.id) {
                    person in
                    Text("\(person.firstName) \(person.lastName)")
                }
            }
        } else {
            Text("Fetch the users first please")
        }
    }
}

struct addNewUserView: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var added: String?
    
    var body: some View {
        Form {
            TextField("First Name", text: $firstName)
            TextField("Last Name", text: $lastName)
            Button("Add User") {
                if !firstName.isEmpty && !lastName.isEmpty {
                    let newUser = NewUser(firstName:firstName,lastName:lastName)
                    AF.request("https://dummyjson.com/users/add",
                        method: .post,
                        parameters: newUser,
                        encoder: JSONParameterEncoder.default)
                        .responseDecodable(of: Person.self) { response in
                            if let result = response.value{
                            added =
                            "New user: \(result.firstName) \(result.lastName)"
                            }
                        }
                } else {
                    added = "Can't add empty"
                }
            }
            if let added = added {
                Text(added)
            }
        }
    }
}
