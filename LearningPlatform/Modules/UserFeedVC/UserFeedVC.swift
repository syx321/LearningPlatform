//
//  UserFeedVC.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/5/11.
//

import Foundation
import UIKit

protocol UserFeedHeaderViewDelegate: AnyObject {
    func didTapAvatar(userId: String)
    func didTapFollow(userId: String)
    func didClickCell(model: MainPageFeedCellModel)
}

final class UserFeedHeaderView: UICollectionReusableView {
    
}

final class UserFeedVC: BaseViewController {
    private let model: VideoPlayerModel
    private let useCase: MainPageFeedUseCase?
    private let resolver: DIResolvable?
    
    private lazy var feedView: MainPageFeedView = {
        let v = MainPageFeedView(frame: .zero)
        v.collectionView.register(UserFeedHeaderView.self,
                                  forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                  withReuseIdentifier: NSStringFromClass(UserFeedHeaderView.self))
        v.delegate = self
        return v
    }()
    
    init(resolver: DIResolvable?, model: VideoPlayerModel) {
        self.model = model
        self.resolver = resolver
        self.useCase = MainPageFeedUseCase(resolver: resolver)
        super.init(nibName: nil, bundle: nil)
        useCase?.delegate = self
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UserFeedVC {
    private func setupViews() {
        
    }
}

extension UserFeedVC: MainPageFeedViewDelegate {
    func didClickCell(model: MainPageFeedCellModel) {
        useCase?.gotoUserPage(id: model.id)
    }
}

extension UserFeedVC: MainPageFeedUseCaseDelegate {
    func didFetchFeedModels(models: [MainPageFeedCellModel]?) {
        guard let models = models else { return }
        feedView.models = models
    }
}
