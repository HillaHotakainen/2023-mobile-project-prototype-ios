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
}

struct NewUser: Encodable {
    let firstName: String
    let lastName: String
    let age: Int
}

func parseJson(json: Data) -> Array<Person>? {
    do {
        let jsonDecoder = JSONDecoder()
        let httpResult : HttpResult = try jsonDecoder.decode(HttpResult.self, from: json)
        return httpResult.users
    } catch {
        return nil
    }
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
                if(people != nil) {
                    List {
                        ForEach(people!, id: \.firstName) {
                            person in
                            Text("\(person.firstName) \(person.lastName)")
                        }
                    }
                }
                Button("fetch all") {
                    AF.request("https://dummyjson.com/users/").responseDecodable(of: HttpResult.self) { response in
                        if let result = response.value {
                            self.people = result.users
                        }
                    }
                }
            }
        }
    }
}
