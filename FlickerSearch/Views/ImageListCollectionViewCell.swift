//
//  ListCollectionViewCell.swift
//  FlickerSearch
//
//  Created by Oskar Jönsson on 2021-07-08.
//

import UIKit
import SnapKit

protocol ImageListCollectionViewCellDelegate: AnyObject {
    func imageFetchResult(result: Result<UIImage, Error>)
}

class ImageListCollectionViewCell: UICollectionViewCell {

    private let presenter: ImageListCollectionViewCellPresenter

    lazy var listImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.stopAnimating()
        return indicator
    }()

    override init(frame: CGRect) {
        presenter = ImageListCollectionViewCellPresenter()
        super.init(frame: frame)
        presenter.delegate = self
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("Not a storyboard application")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        listImageView.image = nil
        presenter.listCollectionViewCellPrepareForReuseWasCalled(self)
    }

    func setSelected(_ selected: Bool) {
        listImageView.alpha = selected ? 0.8 : 1
        let scale: CGFloat = selected  ? 0.95 : 1
        listImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
    }

    func renderImage(url: URL) {
        activityIndicator.startAnimating()
        presenter.fetchImage(url: url)
    }

    private func setupViews() {
        addSubview(listImageView)
        addSubview(activityIndicator)
    }

    private func setupConstraints() {
        listImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

extension ImageListCollectionViewCell: ImageListCollectionViewCellDelegate {
    func imageFetchResult(result: Result<UIImage, Error>) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            switch result {
            case .success(let image):
                self.listImageView.image = image
            case .failure:
                self.listImageView.image = nil
            }
        }
    }
}
