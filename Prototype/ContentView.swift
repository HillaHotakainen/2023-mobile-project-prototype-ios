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
    let age: Int
    let id : Int
}

struct NewUser: Encodable {
    let firstName: String
    let lastName: String
    let age: Int
}

struct ContentView: View {
    @State var people : Array<Person>? = nil
    @State var firstName = ""
    @State var lastName = ""
    @State var age = "1"
    
    var body: some View {
        NavigationStack{
            VStack {
                Text("Prototype").font(.largeTitle)
                    NavigationLink {
                        allUsersview(people: people)
                    } label: {
                        Label("All users", systemImage: "")
                    }
                    .navigationTitle("Prototype")
                
                Button("fetch all") {
                    AF.request("https://dummyjson.com/users/")
                        .responseDecodable(of: HttpResult.self) { response in
                        if let result = response.value {
                            self.people = result.users
                        }
                    }
                }
            }
        }
    }
}
struct allUsersview: View {
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
