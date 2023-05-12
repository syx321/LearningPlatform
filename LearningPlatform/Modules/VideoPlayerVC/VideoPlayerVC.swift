//
//  VideoPlayerVC.swift
//  LearningPlatform
//
//  Created by 苏易肖 on 2023/5/5.
//

import Foundation
import IJKPlayer
import UIKit

final class VideoPlayerVC: BaseViewController {
    private let model: VideoPlayerModel
    private let useCase: MainPageFeedUseCase?
    private let resolver: DIResolvable?
    private var userFeedService: UserFeedService?
    private var totalDuration: TimeInterval? {
        didSet {
            guard let totalDuration = totalDuration?.int else { return }
            totalTimeLabel.text = "\(totalDuration.hour):\(totalDuration.minute):\(totalDuration.second)"
        }
    }
    private var currentTime: TimeInterval? {
        didSet {
            guard let currentTime = currentTime?.int else { return }
            currentTimeLabel.text = "\(currentTime.hour):\(currentTime.minute):\(currentTime.second)"
        }
    }
    private var showingControlViews: Bool = false
    
    private var playerConfig: MDIJKPlayerConfig {
        guard let urlString = model.videoUrlString,
              let url = URL(string: urlString) else { fatalError("urlString is nil") }
        let config = MDIJKPlayerConfig.defaultFullScreenPlay()
        config.inView = playerContainerView
        config.url = url
        config.loop = 0
        config.scaleMode = .aspectFit
        return config
    }
    
    private lazy var player: MDIJKPlayer = {
        let player = MDIJKPlayer(config: playerConfig, delegate: self)
        return player
    }()
    
    private lazy var playerContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .black
        let tapGesterRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickView))
        v.addGestureRecognizer(tapGesterRecognizer)
        return v
    }()
    
    private lazy var pauseBtn: UIImageView = {
        let v = UIImageView()
        v.image = UIImage(systemName: "play.rectangle")
        v.contentMode = .scaleAspectFit
        v.isUserInteractionEnabled = true
        v.isHidden = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(pauseBtnClicked))
        v.addGestureRecognizer(tapGestureRecognizer)
        return v
    }()
    
    private lazy var bottomContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.isHidden = true
        return v
    }()
    
    private lazy var currentTimeLabel: UILabel = {
        let v = UILabel()
        v.backgroundColor = .clear
        v.font = .systemFont(ofSize: 10)
        v.textColor = .white
        return v
    }()
    
    private lazy var totalTimeLabel: UILabel = {
        let v = UILabel()
        v.backgroundColor = .clear
        v.font = .systemFont(ofSize: 10)
        v.textColor = .white
        return v
    }()
    
    private lazy var progressView: UISlider = {
        let v = UISlider()
        v.minimumValue = 0.0
        v.maximumValue = 1.0
        v.value = 0
        v.minimumTrackTintColor = .black
        v.maximumTrackTintColor = .white
        v.thumbTintColor = .white
        v.addTarget(self, action: #selector(progressViewDidSlide), for: .editingDidEnd)
        return v
    }()
    
    private lazy var feedView: VideoPlayerFeedView = {
        let v = VideoPlayerFeedView(resolver: resolver, model: model)
        v.delegate = self
        return v
    }()
    
    init(resolver: DIResolvable?, model: VideoPlayerModel) {
        self.model = model
        self.resolver = resolver
        self.userFeedService = resolver?(UserFeedService.self)
        self.useCase = MainPageFeedUseCase(resolver: resolver)
        super.init(nibName: nil, bundle: nil)
        useCase?.delegate = self
        shouldAllowRotate = true
        setupViews()
        registerObserver()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeLeft
    }
}

// MARK: - LifeCycle
extension VideoPlayerVC {
    override func viewDidLoad() {
        player.prepareToPlay()
        useCase?.fetchFeedData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        player.play()
        player.updateRenderViewFrame(playerContainerView.frame)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        player.stop()
    }
}

// MARK: - private
extension VideoPlayerVC {
    private func setupViews() {
        view.backgroundColor = .yellow
        view.addSubview(playerContainerView)
        playerContainerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(92)
            $0.height.equalTo(300)
        }
        playerContainerView.addSubview(pauseBtn)
        pauseBtn.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(CGSize(width: 45, height: 45))
        }
        
        playerContainerView.addSubview(bottomContainerView)
        bottomContainerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-10)
            $0.height.equalTo(50)
        }
        
        bottomContainerView.addSubview(currentTimeLabel)
        currentTimeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        bottomContainerView.addSubview(totalTimeLabel)
        totalTimeLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        bottomContainerView.addSubview(progressView)
        progressView.snp.makeConstraints {
            $0.leading.equalTo(currentTimeLabel.snp.trailing).offset(5)
            $0.trailing.equalTo(totalTimeLabel.snp.leading).offset(-5)
            $0.centerX.centerY.equalToSuperview()
        }
        
        view.addSubview(feedView)
        feedView.snp.makeConstraints {
            $0.top.equalTo(playerContainerView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func updateConstraints(isHorizontal: Bool) {
        print("updateConstraints" + isHorizontal.description)
        if isHorizontal {
            setNavigationBarHidden(true)
            playerContainerView.snp.remakeConstraints {
                $0.edges.equalToSuperview()
                $0.top.equalToSuperview().offset(44)
            }
            feedView.isHidden = true
        } else {
            setNavigationBarHidden(false)
            playerContainerView.snp.remakeConstraints {
                $0.leading.trailing.equalToSuperview()
                $0.top.equalToSuperview().offset(92)
                $0.height.equalTo(300)
            }
            feedView.isHidden = false
        }
    }
    
    private func registerObserver() {
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange(_:)), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc private func orientationDidChange(_ note: NSNotification) {
        let orientation = UIDevice.current.orientation
        switch orientation {
        case .landscapeLeft, .landscapeRight:
            updateConstraints(isHorizontal: true)
        case .portrait:
            updateConstraints(isHorizontal: false)
        default:
            break
        }
    }
    
    @objc private func clickView() {
        if showingControlViews {
            hideControlViews()
        } else {
            showControlViews()
        }
    }
    
    private func showControlViews() {
        UIView.animate(withDuration: 0.4) {
            self.pauseBtn.isHidden = false
            self.bottomContainerView.isHidden = false
            self.showingControlViews = true
        } completion: { _ in
            self.showingControlViews = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+7) {
            self.hideControlViews()
        }
    }
    
    private func hideControlViews() {
        UIView.animate(withDuration: 0.4) {
            self.pauseBtn.isHidden = true
            self.bottomContainerView.isHidden = true
            self.showingControlViews = false
        } completion: { _ in
            self.showingControlViews = false
        }
    }
    
    @objc private func progressViewDidSlide() {
        guard let totalDuration = totalDuration, player.isPrepared() else { return }
        let value = progressView.value
        let seekToTime = value * Float(totalDuration)
        player.seek(totalDuration)
    }
    
    @objc private func pauseBtnClicked() {
        print("pauseBtnClicked")
        if player.isPlaying() {
            player.pause()
        } else {
            player.play()
        }
    }
}

// MARK: - MDIJKPlayerDelegate
extension VideoPlayerVC: MDIJKPlayerDelegate {
    func ijkPlayer(_ player: MDIJKPlayer!, isFailedLoadWithError error: Error!) {
        // 打印错误信息
        print("error" + error.debugDescription)
    }
    
    func ijkPlayer(_ player: MDIJKPlayer!, isReadyToPlayWithDuration duration: TimeInterval) {
        totalDuration = duration
    }
    
    func ijkPlayer(_ player: MDIJKPlayer!, playToSeconds seconds: TimeInterval) {
        // 改变进度条状态
        guard let totalDuration = totalDuration else { return }
        currentTime = seconds
        progressView.value = Float(seconds/totalDuration)
    }
    
    func ijkPlayer(_ player: MDIJKPlayer!, playStateChanged state: MPMoviePlaybackState) {
        // 设置播放/暂停按钮
        switch state {
        case .playing:
            pauseBtn.image = UIImage(systemName: "pause.rectangle")
        default:
            pauseBtn.image = UIImage(systemName: "play.rectangle")
        }
    }
    
}

extension VideoPlayerVC: MainPageFeedUseCaseDelegate {
    func didFetchFeedModels(models: [MainPageFeedCellModel]?) {
        feedView.setModels(models: models)
    }
}

extension VideoPlayerVC: VideoPlayerFeedViewDelegate {
    func didTapAvatar(userId: String) {
        
    }
    
    func didTapFollow(userId: String) {
        
    }
    
    func didClickCell(model: MainPageFeedCellModel) {
        useCase?.gotoPlayerPage(id: model.id)
    }
}
