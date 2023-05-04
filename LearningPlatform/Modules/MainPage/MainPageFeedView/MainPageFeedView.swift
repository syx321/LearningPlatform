//
//  MainPageFeedView.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/4/24.
//

import Foundation
import UIKit

protocol MainPageFeedViewService: AnyObject {
    func getCollectionView() -> UIView
    func refreshData(models: [MainPageFeedCellModel])
}

final class MainPageFeedView: UIView {
    private var models: [MainPageFeedCellModel] = [] {
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
        v.register(MainPageFeedCell.self, forCellWithReuseIdentifier: NSStringFromClass(MainPageFeedCell.self))
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
        addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - MainPageFeedViewService
extension MainPageFeedView: MainPageFeedViewService {
    func getCollectionView() -> UIView {
        return MainPageFeedView(frame: .zero)
    }
    
    func refreshData(models: [MainPageFeedCellModel]) {
        self.models = models
    }
}

// MARK: - UICollectionViewDelegate
extension MainPageFeedView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let model = models?[indexPath.item, true] else { return }
        
    }
}

// MARK: - UICollectionViewDataSource
extension MainPageFeedView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(MainPageFeedCell.self), for: indexPath) as? MainPageFeedCell else {
            return UICollectionViewCell()
        }
        let model = models[indexPath.item, true]
        cell.model = model
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainPageFeedView: UICollectionViewDelegateFlowLayout {}
