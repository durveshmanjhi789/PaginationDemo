//
//  ProfileModel.swift
//  PaginationDemo
//
//  Created by Durvesh Manjhi on 22/07/25.
//

struct APIResponse: Codable {
    let data: [User]
}

struct User: Codable {
    let image: String
    let email: String
    let name: String
    let age: Int
    let dob: String
}
