//
//  IntroViewController.swift
//  UIKitCatalog
//
//  Created by Philip Krück on 26.03.19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import APLVideoPlayerView

protocol IntroViewControllerDelegate: NSObjectProtocol {
    func introViewControllerDidFinishPlayingVideo(_ controller: IntroViewController)
    func introViewControllerDidGetTapped(_ controller: IntroViewController)
    func introViewControllerVideoPlayerIsReadyToPlay(_ controller: IntroViewController)
}

class IntroViewController: UIViewController {

    // MARK: public properties
    weak var delegate: IntroViewControllerDelegate?
    var imageName: String?
    var videoName: String?
    var canDismissViewControllerWithTouch = false
    var videoDoesLoop = false
    var isStatusBarHidden = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }

    // MARK: private properties
    private var imageView: UIImageView!
    private var videoPlayerView: APLVideoPlayerView!
    private static var keyValueObservationContext = 0

    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        videoPlayerView.avPlayer.removeObserver(self, forKeyPath: "status", context: &IntroViewController.keyValueObservationContext)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addImageView()
        addVideoPlayerView()

        if canDismissViewControllerWithTouch {
            addTapGestureRecognizer()
        }

        NotificationCenter.default.addObserver(self, selector: #selector(videoDidFinishNotification(notification:)), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: nil)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupVideoPlayer()
    }

    func addImageView() {
        if let imageName = imageName {
            let image = UIImage(named: imageName)
            imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFill
            view.insertSubview(imageView, at: 0)

            // auto layout constraints
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
            imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        }
    }

    func addVideoPlayerView() {
        videoPlayerView = APLVideoPlayerView()
        view.insertSubview(videoPlayerView, at: 1)

        // auto layout constraints
        videoPlayerView.translatesAutoresizingMaskIntoConstraints = false
        videoPlayerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        videoPlayerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        videoPlayerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        videoPlayerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }

    func addTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTouchUpInsideScreen(sender:)))
        view.addGestureRecognizer(tapGestureRecognizer)
    }

    func setupVideoPlayer() {
        if let videoFileName = videoName {
            videoPlayerView.setVideoFilename(videoFileName, loop: videoDoesLoop)
            videoPlayerView.videoGravity = .resizeAspectFill
            videoPlayerView.avPlayer.actionAtItemEnd = .pause
            videoPlayerView.avPlayer.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions.new, context: &IntroViewController.keyValueObservationContext)
            videoPlayerView.play()
        }
    }

    @objc func didTouchUpInsideScreen(sender: Any?) {
        delegate?.introViewControllerDidGetTapped(self)
    }

    @objc func videoDidFinishNotification(notification: Notification) {
        delegate?.introViewControllerDidFinishPlayingVideo(self)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard context == &IntroViewController.keyValueObservationContext else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }

        if keyPath == "status" {
            if videoPlayerView.avPlayer.status == .readyToPlay {
                delegate?.introViewControllerVideoPlayerIsReadyToPlay(self)
            }
        }
    }
}
