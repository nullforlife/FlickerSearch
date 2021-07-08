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

    func fetchElectroluxImages(completion: @escaping(_ result: Result<[Image], Error>) -> Void) {

        let baseURL = URL(string: "https://api.flickr.com")!.appendingPathComponents([
            "services",
            "rest"
        ])

        var components = URLComponents(string: baseURL.absoluteString)
        let queries: [URLQueryItem] = [
            .init(name: "api_key", value: "6d153a538c65a16116d5d054c6cd8a6d"),
            .init(name: "method", value: "flickr.photos.search"),
            .init(name: "tags", value: "Electrolux"),
            .init(name: "format", value: "json"),
            .init(name: "nojsoncallback", value: "1"),
            .init(name: "extras", value: "media"),
            .init(name: "extras", value: "url_sq"),
            .init(name: "extras", value: "url_m"),
            .init(name: "text", value: "Electrolux")
        ]

        components?.queryItems = queries

        guard let url = components?.url else { return }
        let request = URLRequest(url: url)
        manager.fetchData(request: request, model: ImageResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response.photos.photo))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    private struct ImageResponse: Decodable {
        let photos: PhotoList

        struct PhotoList: Decodable {
            let photo: [Image]
        }
    }
}
