//
//  MainPageController.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/4/22.
//

import Foundation
import UIKit

final class MainPageController: BaseViewController {
    private let resolver: DIResolvable?
    private let useCase: MainPageFeedUseCase
    private lazy var collectionView: MainPageFeedView = {
        MainPageFeedView(frame: .zero)
    }()
    init(resolver: DIResolvable?) {
        self.resolver = resolver
        useCase = MainPageFeedUseCase()
        super.init(nibName: nil, bundle: nil)
        useCase.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var perfersNavigationBarHidden: Bool {
        return false
    }
}

// MARK: - private
extension MainPageController {
    override func viewDidLoad() {
        title = "主页"
        setupService()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        useCase.fetchFeedData()
    }
    
    private func setupService() {
        
    }
    
    private func setupViews() {
        view.backgroundColor = .red
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalToSuperview().offset(50)
        }
    }
}

extension MainPageController: MainPageFeedUseCaseDelegate {
    func didFetchFeedModels(models: [MainPageFeedCellModel]?) {
        guard let models = models, models.count > 0 else { return }
        collectionView.models = models
    }
    
    
}
