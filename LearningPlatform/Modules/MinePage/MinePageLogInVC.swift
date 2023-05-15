//
//  MinePageLogInVC.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/5/12.
//

import Foundation
import UIKit

final class MinePageLogInVC: UIViewController {
    private lazy var userAvatarImageView: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(systemName: "person.crop.circle")
        return v
    }()
    
    private lazy var userNameLabel: UILabel = {
        let v = UILabel()
        v.text = "用户名:"
        return v
    }()
    
    private lazy var userNameInputTextView: UITextView = {
        let v = UITextView()
        v.backgroundColor = UIColor(white: 0.8, alpha: 0.4)
        v.layer.cornerRadius = 5
        v.layer.masksToBounds = true
        return v
    }()
    
    private lazy var passwordLabel: UILabel = {
        let v = UILabel()
        v.text = "密码:"
        return v
    }()
    
    private lazy var passwordInputTextView: UITextView = {
        let v = UITextView()
        v.backgroundColor = UIColor(white: 0.8, alpha: 0.4)
        v.layer.cornerRadius = 5
        v.layer.masksToBounds = true
        return v
    }()
    
    private lazy var confirmButton: UIButton = {
        let v = UIButton()
        v.setTitle("注册或登录", for: .normal)
        v.titleLabel?.font = .systemFont(ofSize: 14)
        v.contentEdgeInsets = UIEdgeInsets(top: 8, left: 13, bottom: 8, right: 13)
        v.backgroundColor = .blue
        v.layer.cornerRadius = 7
        v.layer.masksToBounds = true
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

extension MinePageLogInVC {
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(userAvatarImageView)
        userAvatarImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-250)
            $0.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        view.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(40)
            $0.top.equalTo(userAvatarImageView.snp.bottom).offset(20)
            $0.width.equalTo(60)
        }
        
        view.addSubview(userNameInputTextView)
        userNameInputTextView.snp.makeConstraints {
            $0.leading.equalTo(userNameLabel.snp.trailing).offset(10)
            $0.centerY.equalTo(userNameLabel)
            $0.trailing.equalToSuperview().offset(-40)
            $0.height.equalTo(25)
        }
        
        view.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(40)
            $0.top.equalTo(userNameLabel.snp.bottom).offset(13)
            $0.width.equalTo(60)
        }
        
        view.addSubview(passwordInputTextView)
        passwordInputTextView.snp.makeConstraints {
            $0.leading.equalTo(passwordLabel.snp.trailing).offset(10)
            $0.centerY.equalTo(passwordLabel)
            $0.trailing.equalToSuperview().offset(-40)
            $0.height.equalTo(25)
        }
        
        view.addSubview(confirmButton)
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(passwordInputTextView.snp.bottom).offset(25)
            $0.centerX.equalToSuperview()
        }
    }
}
