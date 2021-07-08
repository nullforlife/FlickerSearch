//
//  ViewController.swift
//  FlickerSearch
//
//  Created by Oskar Jönsson on 2021-07-08.
//

import UIKit
import SnapKit

class ElectroluxImageListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ElectroluxImageListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
}

extension ElectroluxImageListViewController: UICollectionViewDelegateFlowLayout {

}
