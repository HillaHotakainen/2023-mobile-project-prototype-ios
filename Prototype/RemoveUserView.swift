//
//  RemoveUserView.swift
//  Prototype
//
//  Created by Hilla Hotakainen on 9.5.2023.
//

import Foundation
import SwiftUI
import Alamofire

struct removeUserView: View {
    @State var ID: String = ""
    @State var deleted: String?
    
    var body: some View {
        Form {
            TextField("Give ID", text: $ID)
            Button("Remove user") {
                guard let intID: Int = Int(ID) else {
                    self.deleted = "please give numbers"
                    return
                }
                if intID > 0 {
                    AF.request("https://dummyjson.com/users/\(intID)",
                        method:.delete)
                    .responseDecodable(of: Person.self) {
                            response in
                            if let result = response.value {
                                self.deleted = """
                                Deleted user:
                                \(result.firstName) \(result.lastName)
                                """
                            } else {
                                self.deleted = "User not found"
                            }
                        }
                } else {
                    self.deleted = "ID can not be empty"
                }
            }
            if let deleted = deleted {
                Text(deleted)
            }
        }
    }
}
