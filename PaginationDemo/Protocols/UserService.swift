//
//  UserService.swift
//  PaginationDemo
//
//  Created by Durvesh Manjhi on 25/07/25.
//

protocol UserService{
    func fetchUsers() async throws -> [User]
}
