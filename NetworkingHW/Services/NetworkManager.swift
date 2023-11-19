//
//  NetworkManager.swift
//  NetworkingHW
//
//  Created by testing on 15.11.2023.
//

import Foundation
import Alamofire

enum Link {
    case photosURL
    case postsURL
    case todosURL
    case infoURL
    
    var url: URL! {
        switch self {
        case .photosURL:
            return URL(string: "https://jsonplaceholder.typicode.com/photos")
        case .postsURL:
            return URL(string: "https://jsonplaceholder.typicode.com/posts")
        case .todosURL:
            return URL(string: "https://jsonplaceholder.typicode.com/todos")
        case .infoURL:
            return URL(string: "https://api.tvmaze.com/shows/1/seasons")
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(from url: URL, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let imageData):
                    completion(.success(imageData))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetch<T: Decodable>(_ type: T.Type, from url: URL, completion: @escaping(Result<T, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
