//
//  ElectroLuxImageListPresenter.swift
//  FlickerSearch
//
//  Created by Oskar Jönsson on 2021-07-08.
//

import Foundation

class ElectroLuxImageListPresenter {
    weak var delegate: ElextroLuxImageViewControllerDelegate?

    private let service = SearchService()

    func fetchImages() {
        service.fetchElectroluxImages { [weak self] result in
            self?.delegate?.imageFetchResult(result: result)
        }
    }
}
