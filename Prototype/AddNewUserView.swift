//
//  AddNewUserView.swift
//  Prototype
//
//  Created by Hilla Hotakainen on 9.5.2023.
//

import Foundation
import SwiftUI
import Alamofire

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
                            added = """
                            Added new user:
                            \(result.firstName) \(result.lastName)
                            """
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
