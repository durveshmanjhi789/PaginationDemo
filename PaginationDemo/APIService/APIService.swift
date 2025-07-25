//
//  APIService.swift
//  PaginationDemo
//
//  Created by Durvesh Manjhi on 22/07/25.
//

import Foundation

class APIService {
    static let shared = APIService()
    
    private init(){}
    
    func fetchUsers( completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: "https://core-apis.a1apps.co/ios/interview-details") else {
                   return
               }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else { return }
            do {
                let decoded = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(.success(decoded.data))
            } catch {
                print("Decoding error:", error)
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchUsersAsync() async throws -> [User]{
        guard let url = URL(string: "https://core-apis.a1apps.co/ios/interview-details") else{
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(APIResponse.self, from: data)
        return decoded.data
        
    }
 
}
