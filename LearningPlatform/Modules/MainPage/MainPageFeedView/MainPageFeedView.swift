//
//  MainPageFeedView.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/4/24.
//

import Foundation
import UIKit

protocol MainPageFeedViewDelegate: AnyObject {
    func didClickCell(model: MainPageFeedCellModel)
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize
}

extension MainPageFeedViewDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView { return UICollectionReusableView() }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize { return .zero }
}

final class MainPageFeedView: UIView {
    weak var delegate: MainPageFeedViewDelegate?
    
    var models: [MainPageFeedCellModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        let itemWidth: CGFloat = (ScreenWidth - 8*2 - layout.minimumInteritemSpacing)/2
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 4/3.0)
        let v = UICollectionView(frame: .zero, collectionViewLayout: layout)
        v.delegate = self
        v.dataSource = self
        v.showsHorizontalScrollIndicator = false
        v.showsVerticalScrollIndicator = false
        v.backgroundColor = .white
        v.contentInsetAdjustmentBehavior = .never
        v.register(MainPageFeedCell.self, forCellWithReuseIdentifier: MainPageFeedCell.identifier)
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - private
extension MainPageFeedView {
    private func setupView() {
        backgroundColor = .white
        addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDelegate
extension MainPageFeedView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = models[indexPath.item, true] else { return }
        delegate?.didClickCell(model: model)
    }
}

// MARK: - UICollectionViewDataSource
extension MainPageFeedView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainPageFeedCell.identifier, for: indexPath) as? MainPageFeedCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? MainPageFeedCell else {
            return
        }
        let model = models[indexPath.item, true]
        cell.model = model
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let delegate = delegate else { return UICollectionReusableView() }
        return delegate.collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainPageFeedView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth: CGFloat = (ScreenWidth - 10*2 - 5)/2
        return CGSize(width: itemWidth, height: itemWidth * 4/3.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 80, left: 5, bottom: 90, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let delegate = delegate else { return .zero }
        return delegate.collectionView(collectionView, layout: collectionViewLayout, referenceSizeForHeaderInSection: section)
    }
}
