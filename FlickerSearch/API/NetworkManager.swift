//
//  Netowkr.swift
//  FlickerSearch
//
//  Created by Oskar Jönsson on 2021-07-08.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchData<T: Decodable>(request: URLRequest, model: T.Type, completion: (_ result: Result<T, Error>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {

    func fetchData<T: Decodable>(request: URLRequest, model: T.Type, completion: (_ result: Result<T, Error>) -> Void) {

    }
}
