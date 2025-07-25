//
//  UserViewModel.swift
//  PaginationDemo
//
//  Created by Durvesh Manjhi on 22/07/25.
//

import Foundation

class UserViewModel {

    var allUsers: [User] = []
    var visibleUsers: [User] = []
    private var currentIndex = 0
    private let pageSize = 10
    var isLoading = false
    var hasmore:Bool{
        return currentIndex < allUsers.count
    }
    func loadData(completion:@escaping(_ userCount:Int) ->Void){
        APIService.shared.fetchUsers { result in
            DispatchQueue.main.async{
                switch result{
                case .success(let users):
                    self.allUsers = users
                    self.visibleUsers = []
                    self.loadMore()
                    completion(users.count)
                case .failure(let error):
                    print("Failed to fetch users:", error)
                    completion(0)
                }
            }
        }
    }
    func loadMore(){
        let nextIndex = currentIndex + pageSize
        guard currentIndex < allUsers.count else{ return }
        let slice = allUsers[currentIndex..<min(nextIndex, allUsers.count)]
        visibleUsers.append(contentsOf: slice)
        currentIndex = nextIndex

    }
    
    func loadDataAsync() async throws -> Int{
        let users = try await APIService.shared.fetchUsersAsync()
        self.allUsers = users
        self.visibleUsers = []
        self.loadMore()
        return users.count
    }
    
}
