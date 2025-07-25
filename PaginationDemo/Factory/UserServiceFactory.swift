//
//  UserServiceFactory.swift
//  PaginationDemo
//
//  Created by Durvesh Manjhi on 25/07/25.
//

import UIKit

class UserServiceFactory{
    static func createServices() -> UserService{
        return APIService()
    }
}
