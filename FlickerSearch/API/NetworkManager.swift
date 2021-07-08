//
//  Netowkr.swift
//  FlickerSearch
//
//  Created by Oskar Jönsson on 2021-07-08.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchData<T: Decodable>(request: URLRequest, model: T.Type, completion: @escaping(_ result: Result<T, Error>) -> Void)
    func fetchImageData(request: URLRequest, completion: @escaping(_ result: Result<Data, Error>) -> Void) -> URLSessionDataTask
}

class NetworkManager: NetworkManagerProtocol {

    func fetchData<T: Decodable>(request: URLRequest, model: T.Type, completion: @escaping(_ result: Result<T, Error>) -> Void) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in

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
        task.resume()
    }

    func fetchImageData(request: URLRequest, completion: @escaping(_ result: Result<Data, Error>) -> Void) -> URLSessionDataTask {

        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, _, error in
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(error ?? NetworkError.genericError))
            }
        }
        return task
    }

    enum NetworkError: Error {
        case genericError
    }
}
