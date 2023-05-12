//
//  VideoPlayerFeedView.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/5/10.
//

import Foundation
import UIKit

protocol VideoPlayerFeedViewDelegate: AnyObject {
    func didTapAvatar(userId: String)
    func didTapFollow(userId: String)
    func didClickCell(model: MainPageFeedCellModel)
}

protocol VideoPlayerFeedViewHeaderViewDelegate: AnyObject {
    func didTapAvatar(userId: String)
    func didTapFollow(userId: String)
}

final class VideoPlayerFeedViewHeaderView: UICollectionReusableView {
    weak var delegate: VideoPlayerFeedViewHeaderViewDelegate?
    
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
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapAvatar))
        v.addGestureRecognizer(tapGestureRecognizer)
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
    
    @objc private func tapAvatar() {
        guard let ownerId = model?.ownerId else { return }
        delegate?.didTapAvatar(userId: ownerId)
    }
    
    @objc private func tapFollow() {
        guard let ownerId = model?.ownerId else { return }
        delegate?.didTapFollow(userId: ownerId)
    }
}

final class VideoPlayerFeedView: UIView {
    weak var delegate: VideoPlayerFeedViewDelegate?
    private let resolver: DIResolvable?
    private let model: VideoPlayerModel
    
    private lazy var feedView: MainPageFeedView = {
        let v = MainPageFeedView(frame: .zero)
        v.collectionView.register(VideoPlayerFeedViewHeaderView.self,
                                  forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                  withReuseIdentifier: NSStringFromClass(VideoPlayerFeedViewHeaderView.self))
        v.delegate = self
        return v
    }()
    
    init(resolver: DIResolvable?, model: VideoPlayerModel) {
        self.resolver = resolver
        self.model = model
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setModels(models: [MainPageFeedCellModel]?) {
        guard let models = models else { return }
        feedView.models = models
    }
}

extension VideoPlayerFeedView {
    private func setupViews() {
        addSubview(feedView)
        feedView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension VideoPlayerFeedView: MainPageFeedViewDelegate {
    func didClickCell(model: MainPageFeedCellModel) {
        delegate?.didClickCell(model: model)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }
        if let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NSStringFromClass(VideoPlayerFeedViewHeaderView.self), for: indexPath) as? VideoPlayerFeedViewHeaderView,
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

extension VideoPlayerFeedView: VideoPlayerFeedViewHeaderViewDelegate {
    func didTapAvatar(userId: String) {
        delegate?.didTapAvatar(userId: userId)
    }
    
    func didTapFollow(userId: String) {
        delegate?.didTapFollow(userId: userId)
    }
    
    
}
