//
//  ViewController.swift
//  FlickerSearch
//
//  Created by Oskar Jönsson on 2021-07-08.
//

import UIKit
import SnapKit

protocol ElextroLuxImageViewControllerDelegate: AnyObject {
    func imageFetchResult(result: Result<[Image], Error>)
}

class ElectroluxImageListViewController: UIViewController {

    let presenter: ElectroLuxImageListPresenter

    init() {
        presenter = ElectroLuxImageListPresenter()
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

extension ElectroluxImageListViewController: ElextroLuxImageViewControllerDelegate {
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

extension ElectroluxImageListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collec
        cell.backgroundColor = .yellow
        return cell
    }
}

extension ElectroluxImageListViewController: UICollectionViewDelegateFlowLayout {

}
