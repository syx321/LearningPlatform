//
//  MainPageController.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/4/22.
//

import Foundation
import UIKit

final class MainPageController: UIViewController {
    private let resolver: DIResolvable?
    init(resolver: DIResolvable?) {
        self.resolver = resolver
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainPageController {
    override func viewDidLoad() {
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .red
    }
}

