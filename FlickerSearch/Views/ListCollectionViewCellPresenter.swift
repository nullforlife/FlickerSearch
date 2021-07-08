//
//  ListCollectionViewCellPresenter.swift
//  FlickerSearch
//
//  Created by Oskar Jönsson on 2021-07-08.
//

import Foundation
import UIKit

class ListCollectionViewCellPresenter {

    weak var delegate: ListCollectionViewCellDelegate?
    var dataTask: URLSessionDataTask?
    private let service = ImageService()

    func fetchImage(url: URL) {
        let request = URLRequest(url: url)
        dataTask = service.fetchImage(request: request, completion: { [weak self] result in
            switch result {
            case .success(let image):
                self?.delegate?.imageFetchResult(result: .success(image))
            case .failure(let error):
                self?.delegate?.imageFetchResult(result: .failure(error))
            }
        })
        dataTask?.resume()
    }

    func listCollectionViewCellPrepareForReuseWasCalled(_ cell: ListCollectionViewCell) {
        dataTask?.cancel()
    }
}
