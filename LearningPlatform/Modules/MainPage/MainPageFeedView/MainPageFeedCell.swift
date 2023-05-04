//
//  MainPageFeedCell.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/4/24.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage

class MainPageFeedCell: UICollectionViewCell {
//    struct Constant {
//        static let imageScale: CGFloat = 1.5 // 高宽比
//    }
//
    var model: MainPageFeedCellModel? {
        didSet {
            if model != nil {
                updateViews()
            }
        }
    }
    
    private lazy var containerView: UIView = {
        let v = UIView()
        v.backgroundColor = .black
        v.layer.cornerRadius = 16
        v.layer.masksToBounds = true
        return v
    }()
    
    private lazy var avatarImg: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        return v
    }()
    
    private lazy var nameLabel: UILabel = {
        let v = UILabel()
        v.font = .systemFont(ofSize: 12)
        v.backgroundColor = .clear
        v.textColor = .white
        return v
    }()
    
    private lazy var descLabel: UILabel = {
        let v = UILabel()
        v.font = .systemFont(ofSize: 8)
        v.backgroundColor = .clear
        v.textColor = .white
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - private
private extension MainPageFeedCell {
    func setupViews() {
        addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        containerView.addSubview(avatarImg)
        avatarImg.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        /// 由下向上布局
        containerView.addSubview(descLabel)
        descLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(5)
            $0.bottom.equalToSuperview().offset(-3)
        }
        containerView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.bottom.equalTo(descLabel.snp.top).offset(3)
            $0.leading.equalTo(descLabel.snp.leading)
        }
    }
    
    func updateViews() {
        guard let model = model else { return }
        nameLabel.text = model.name
        descLabel.text = model.desc
        if let imageStr = model.avatarUrl,
           let imageUrl = URL(string: imageStr) {
            avatarImg.imageUrl(imageUrl)
        }
    }
}
