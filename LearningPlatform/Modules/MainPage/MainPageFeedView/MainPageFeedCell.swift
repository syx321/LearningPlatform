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
    static let identifier = "MainPageFeedCell"
    
    var model: MainPageFeedCellModel? {
        didSet {
            nameLabel.text = model?.name
            descLabel.text = model?.desc
            if let imageStr = model?.avatarUrl,
               let imageUrl = URL(string: imageStr) {
                avatarImg.imageUrl(imageUrl)
            }
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
    
    private lazy var avatarImg: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleToFill
        return v
    }()
    
    private lazy var nameLabel: UILabel = {
        let v = UILabel()
        v.font = .systemFont(ofSize: 20)
        v.backgroundColor = .clear
        v.textColor = .white
        v.numberOfLines = 1
        return v
    }()
    
    private lazy var descLabel: UILabel = {
        let v = UILabel()
        v.font = .systemFont(ofSize: 15)
        v.backgroundColor = .clear
        v.textColor = .white
        v.numberOfLines = 1
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
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .black
        
        contentView.addSubview(avatarImg)
        avatarImg.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        /// 由下向上布局
        contentView.addSubview(descLabel)
        descLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(5)
            $0.bottom.equalToSuperview().offset(-10)
        }
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(descLabel.snp.leading)
            $0.bottom.equalTo(descLabel.snp.top).offset(-3)
        }
    }
}
