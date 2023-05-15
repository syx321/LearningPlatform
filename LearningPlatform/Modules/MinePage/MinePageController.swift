//
//  MinePageController.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/4/22.
//

import Foundation
import UIKit

enum ButtonType {
    case follow
    case collect
}

protocol MinePageHeadeerViewDelegate: AnyObject {
    func didClickButton(type: ButtonType)
}

final class MinePageHeadeerView: UIView {
    lazy var avatarImageView: UIImageView = {
        let v = UIImageView()
        v.imageUrl(URL(string: "https://auto.tancdn.com/v1/raw/961614f8-1e7a-4494-8970-78c48cba3a390203.png"))
        return v
    }()
    
    lazy var userNameLabel: UILabel = {
        let v = UILabel()
        v.text = "姓名测试"
        return v
    }()
    
    private var lineView: UIView = {
        let v = UIView()
        v.backgroundColor = .gray
        return v
    }()
    
    lazy var followListBtn: UIButton = {
        let v = UIButton()
        v.setTitle("关注列表", for: .normal)
        v.titleLabel?.font = .systemFont(ofSize: 14)
        v.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        v.backgroundColor = .blue
        v.layer.cornerRadius = 7
        v.layer.masksToBounds = true
//        v.addTarget(self, action: #selector(tapFollow), for: .touchUpInside)
        return v
    }()
    
    lazy var collectListBtn: UIButton = {
        let v = UIButton()
        v.setTitle("收藏列表", for: .normal)
        v.titleLabel?.font = .systemFont(ofSize: 14)
        v.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        v.backgroundColor = .blue
        v.layer.cornerRadius = 7
        v.layer.masksToBounds = true
        return v
    }()
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(140)
            $0.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints {
            $0.leading.equalTo(avatarImageView.snp.trailing)
            $0.centerY.equalTo(avatarImageView)
        }
        
        addSubview(lineView)
        lineView.snp.makeConstraints {
            $0.top.equalTo(avatarImageView.snp.bottom).offset(18)
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview().inset(15)
        }
        
        addSubview(followListBtn)
        followListBtn.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(10)
            $0.trailing.equalTo(self.snp.centerX).offset(-30)
        }
        
        addSubview(collectListBtn)
        collectListBtn.snp.makeConstraints {
            $0.top.equalTo(followListBtn)
            $0.leading.equalTo(self.snp.centerX).offset(30)
        }
    }
}

final class FollowListViewCell: UITableViewCell {
    var model: MinePageModel?
    private lazy var avatarImageView: UIImageView = {
        let v = UIImageView()
        v.layer.cornerRadius = 15
        v.layer.masksToBounds = true
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints {
            $0.leading.equalTo(avatarImageView.snp.trailing).offset(10)
            $0.centerY.equalTo(avatarImageView)
            $0.height.equalTo(30)
            $0.width.equalTo(100)
        }
        
        addSubview(followButton)
        followButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview()
        }
    }
    
    @objc private func tapFollow() {
        
    }
}

final class MinePageController: BaseViewController {
    private let resolver: DIResolvable?
    private let useCase: MainPageFeedUseCase
    
    lazy var headerView: MinePageHeadeerView = {
        let v = MinePageHeadeerView()
        return v
    }()
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.isPagingEnabled = true
        v.isScrollEnabled = false
        v.showsHorizontalScrollIndicator = false
        v.showsVerticalScrollIndicator = false
        v.contentInsetAdjustmentBehavior = .never
        v.decelerationRate = .fast
        v.contentSize = CGSize(width: ScreenWidth * 2, height: 100)
        v.backgroundColor = .white
        return v
    }()
    
    lazy var followListView: UITableView = {
        let v = UITableView(frame: .zero)
        v.backgroundColor = .clear
        v.separatorStyle = .none
        v.delegate = self
        v.dataSource = self
        v.register(FollowListViewCell.self, forCellReuseIdentifier: NSStringFromClass(FollowListViewCell.self))
        return v
    }()
    
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
        return true
    }
    
}

extension MinePageController {
    override func viewDidLoad() {
        title = "我的"
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(250)
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }
}

extension MinePageController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(FollowListViewCell.self), for: indexPath) as? FollowListViewCell else { return UITableViewCell() }
        return cell
    }
    
    
}

// MARK: - MainPageFeedUseCaseDelegate
extension MinePageController: MainPageFeedUseCaseDelegate {
    func didFetchFeedModels(models: [MainPageFeedCellModel]?) {
        guard let models = models, models.count > 0 else { return }
        collectionView.models = models
    }
}

// MARK: - MainPageFeedViewDelegate
extension MinePageController: MainPageFeedViewDelegate {
    func didClickCell(model: MainPageFeedCellModel) {
        useCase.gotoPlayerPage(id: model.id)
    }
    
}
