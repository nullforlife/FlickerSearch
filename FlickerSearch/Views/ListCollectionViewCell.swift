//
//  ListCollectionViewCell.swift
//  FlickerSearch
//
//  Created by Oskar Jönsson on 2021-07-08.
//

import UIKit
import SnapKit

protocol ListCollectionViewCellDelegate: AnyObject {
    func imageFetchResult(result: Result<UIImage, Error>)
}

class ListCollectionViewCell: UICollectionViewCell {

    private let presenter: ListCollectionViewCellPresenter

    private lazy var listImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    override init(frame: CGRect) {
        presenter = ListCollectionViewCellPresenter()
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
        presenter.fetchImage(url: url)
    }

    private func setupViews() {
        addSubview(listImageView)
    }

    private func setupConstraints() {
        listImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ListCollectionViewCell: ListCollectionViewCellDelegate {
    func imageFetchResult(result: Result<UIImage, Error>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let image):
                self.listImageView.image = image
            case .failure:
                self.listImageView.image = nil
            }
        }
    }
}
