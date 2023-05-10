//
//  UpdateUserview.swift
//  Prototype
//
//  Created by Hilla Hotakainen on 9.5.2023.
//

import Foundation
import SwiftUI
import Alamofire

struct updateUserView: View {
    @State var ID: String = ""
    @State var fName: String = ""
    @State var lName: String = ""
    @State var updated: String?
    
    var body: some View {
        Form {
            TextField("Give user ID", text: $ID)
            TextField("First Name", text: $fName)
            TextField("Last Name", text: $lName)
            Button("Update user") {
                let intID: Int = Int(ID)!
                let updatedUser = UpdatedUser(firstName:fName,lastName:lName)
                if intID > 0 {
                    AF.request("https://dummyjson.com/users/\(intID)",
                        method:.put,
                        parameters: updatedUser)
                    .responseDecodable(of: Person.self) {
                        response in
                        if let result = response.value {
                            self.updated = """
                            Updated user to:
                            \(result.firstName) \(result.lastName)
                            """
                        } else {
                            self.updated = "User not found"
                            }
                        }
                } else {
                    self.updated = "ID can not be empty"
                }
            }
            if let updated = updated {
                Text(updated)
            }
        }
    }
}

