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
    private var videoPlayerService: VideoPlayerService?
    
    private lazy var collectionView: MainPageFeedView = {
        let v = MainPageFeedView(frame: .zero)
        v.delegate = self
        return v
    }()
    
    init(resolver: DIResolvable?) {
        self.resolver = resolver
        useCase = MainPageFeedUseCase(resolver: resolver)
        super.init(nibName: nil, bundle: nil)
        useCase.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var perfersNavigationBarHidden: Bool {
        return false
    }
    
    override func viewDidLoad() {
        title = "主页"
        setupService()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        useCase.fetchFeedData()
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

// MARK: - private
extension MainPageController {
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalToSuperview().offset(50)
        }
    }
    
    private func setupService() {
        videoPlayerService = resolver?(VideoPlayerService.self)
    }
}

// MARK: - MainPageFeedUseCaseDelegate
extension MainPageController: MainPageFeedUseCaseDelegate {
    func didFetchFeedModels(models: [MainPageFeedCellModel]?) {
        guard let models = models, models.count > 0 else { return }
        collectionView.models = models
    }
}

// MARK: - MainPageFeedViewDelegate
extension MainPageController: MainPageFeedViewDelegate {
    func didClickCell(model: MainPageFeedCellModel) {
        useCase.gotoPlayerPage(id: model.id)
    }
}
