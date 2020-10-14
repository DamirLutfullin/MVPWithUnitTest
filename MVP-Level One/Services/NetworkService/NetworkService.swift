//
//  NetworkService.swift
//  MVP-Level One
//
//  Created by Damir Lutfullin on 13.10.2020.
//

import Foundation

protocol NetworkServiceProtocol: class {
    func downloadComments(completion: @escaping (Result<[Comment], Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    func downloadComments(completion: @escaping (Result<[Comment], Error>) -> Void) {
        let urlSrting = "https://jsonplaceholder.typicode.com/comments"
        guard let url = URL(string: urlSrting) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            
            do {
                let comments = try JSONDecoder().decode([Comment].self, from: data)
                completion(.success(comments))
            } catch  {
                completion(.failure(error))
            }
        }.resume()
    }
}
