//
//  ElectroLuxImageListPresenter.swift
//  FlickerSearch
//
//  Created by Oskar Jönsson on 2021-07-08.
//

import Foundation
import UIKit

class ImageListPresenter {
    weak var delegate: ImageListViewControllerDelegate?

    private let service = SearchService()
    private var selectedImage: UIImage?

    func fetchImages() {
        service.fetchElectroluxImages { [weak self] result in
            self?.delegate?.imageFetchResult(result: result)
        }
    }

    func imageSelected(_ image: UIImage) {
        selectedImage = image
    }

    func saveSelectedImage() {
        guard let image = selectedImage else { return }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        delegate?.imageSaved()
    }
}
