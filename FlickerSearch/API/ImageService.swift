//
//  ImageService.swift
//  FlickerSearch
//
//  Created by Oskar Jönsson on 2021-07-08.
//

import Foundation
import UIKit

class ImageService {

    private let manager: NetworkManagerProtocol

    init(manager: NetworkManagerProtocol = NetworkManager()) {
        self.manager = manager
    }

    func fetchImage(request: URLRequest, completion: @escaping(_ result: Result<UIImage, Error>) -> Void) -> URLSessionDataTask {
        manager.fetchImageData(request: request) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    completion(.failure(ImageFetchError.genericImageFetchError))
                    return
                }
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    enum ImageFetchError: Error {
        case genericImageFetchError
    }
}
