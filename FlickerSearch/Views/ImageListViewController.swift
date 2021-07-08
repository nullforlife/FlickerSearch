//
//  ViewController.swift
//  FlickerSearch
//
//  Created by Oskar Jönsson on 2021-07-08.
//

import UIKit
import SnapKit

protocol ImageListViewControllerDelegate: AnyObject {
    func imageFetchResult(result: Result<[Image], Error>)
}

class ImageListViewController: UIViewController {

    let presenter: ImageListPresenter

    init() {
        presenter = ImageListPresenter()
        super.init(nibName: nil, bundle: nil)
        presenter.delegate = self
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Not a storyboard application")
    }

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageListCollectionViewCell.self, forCellWithReuseIdentifier: ImageListCollectionViewCell.reuseIdentifier)
        return collectionView
    }()

    private var images: [Image] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        presenter.fetchImages()
    }

    private func setupViews() {
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension ImageListViewController: ImageListViewControllerDelegate {
    func imageFetchResult(result: Result<[Image], Error>) {
        switch result {
        case .success(let images):
            self.images = images
        case .failure:
            // Present an error view
            break
        }
    }
}

extension ImageListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageListCollectionViewCell.reuseIdentifier, for: indexPath)
                as? ImageListCollectionViewCell else {
            assertionFailure("Couldn't dequeue the correct cell")
            return UICollectionViewCell()
        }
        let image = images[indexPath.row]
        cell.renderImage(url: image.url_m)
        return cell
    }
}

extension ImageListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 2
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageListCollectionViewCell else { return }
        cell.setSelected(true)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageListCollectionViewCell else { return }
        cell.setSelected(false)
    }
}
