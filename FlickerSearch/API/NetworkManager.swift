//
//  Netowkr.swift
//  FlickerSearch
//
//  Created by Oskar Jönsson on 2021-07-08.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchData<T: Decodable>(request: URLRequest, model: T.Type, completion: @escaping(_ result: Result<T, Error>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {

    func fetchData<T: Decodable>(request: URLRequest, model: T.Type, completion: @escaping(_ result: Result<T, Error>) -> Void) {
        let session = URLSession(configuration: .default)
        session.dataTask(with: request) { data, response, error in

            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(error ?? NetworkError.genericError))
            }
        }
    }

    enum NetworkError: Error {
        case genericError
    }
}
