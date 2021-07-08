//
//  SearchService.swift
//  FlickerSearch
//
//  Created by Oskar Jönsson on 2021-07-08.
//

import Foundation

class SearchService {

    let manager: NetworkManagerProtocol

    init(manager: NetworkManagerProtocol = NetworkManager()) {
        self.manager = manager
    }

    func fetchElectroluxImages() {
        
    }
}
