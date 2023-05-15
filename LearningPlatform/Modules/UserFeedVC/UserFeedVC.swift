//
//  UserFeedVC.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/5/11.
//

import Foundation
import UIKit

protocol UserFeedHeaderViewDelegate: AnyObject {
    func didTapFollow(model: VideoPlayerModel)
}

final class UserFeedHeaderView: UICollectionReusableView {
    weak var delegate: UserFeedHeaderViewDelegate?
    
    var model: VideoPlayerModel? {
        didSet {
            guard let model = model else { return }
            if let urlStr = model.ownerAvatarUrlStr,
               let url = URL(string: urlStr) {
                avatarImageView.imageUrl(url)
            }
            userNameLabel.text = model.ownerName
            titleLabel.text = model.title
        }
    }
    private lazy var avatarImageView: UIImageView = {
        let v = UIImageView()
        return v
    }()
    
    private lazy var userNameLabel: UILabel = {
        let v = UILabel()
        return v
    }()
    
    private lazy var followButton: UIButton = {
        let v = UIButton()
        v.setTitle("+ 关注", for: .normal)
        v.titleLabel?.font = .systemFont(ofSize: 14)
        v.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        v.backgroundColor = .blue
        v.layer.cornerRadius = 7
        v.layer.masksToBounds = true
        v.addTarget(self, action: #selector(tapFollow), for: .touchUpInside)
        return v
    }()
    
    private lazy var titleLabel: UILabel = {
        let v = UILabel()
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.top.equalToSuperview().offset(15)
            $0.size.equalTo(CGSize(width: 25, height: 25))
        }
        
        addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints {
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(10)
            $0.centerY.equalTo(avatarImageView.snp.centerY)
        }
        
        addSubview(followButton)
        followButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-10)
            $0.centerY.equalTo(userNameLabel.snp.centerY)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(avatarImageView.snp.leading)
            $0.top.equalTo(avatarImageView.snp.bottom).offset(25)
        }
    }
    
    @objc private func tapFollow() {
        guard let model = model else { return }
        delegate?.didTapFollow(model: model)
    }
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
    
    override func viewDidLoad() {
        useCase?.fetchFeedData()
    }
}

extension UserFeedVC {
    private func setupViews() {
        view.addSubview(feedView)
        feedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension UserFeedVC: MainPageFeedViewDelegate {
    func didClickCell(model: MainPageFeedCellModel) {
        useCase?.gotoPlayerPage(id: model.id)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        if let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NSStringFromClass(UserFeedHeaderView.self), for: indexPath) as? UserFeedHeaderView,
           indexPath.section == 0{
            view.model = model
            view.delegate = self
            return view
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: ScreenWidth, height: 40)
        }
        return .zero
    }
}

extension UserFeedVC: UserFeedHeaderViewDelegate {
    func didTapFollow(model: VideoPlayerModel) {
        
    }
}

extension UserFeedVC: MainPageFeedUseCaseDelegate {
    func didFetchFeedModels(models: [MainPageFeedCellModel]?) {
        guard let models = models else { return }
        feedView.models = models
    }
}
