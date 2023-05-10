//
//  AllUsersView.swift
//  Prototype
//
//  Created by Hilla Hotakainen on 9.5.2023.
//

import Foundation
import SwiftUI
import Alamofire

struct allUsersView: View {
    @State var people : Array<Person>?
    var body: some View {
        VStack {
            if people != nil {
                List {
                  ForEach(people!, id: \.id) {
                    person in
                    Text("\(person.id) \(person.firstName) \(person.lastName)")
                    }
                }
            }
        }
            .onAppear {
                AF.request("https://dummyjson.com/users/")
                    .responseDecodable(of: HttpResult.self) { response in
                        if let result = response.value {
                            self.people = result.users
                        }
                    }
            }
        }
    }
