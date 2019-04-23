//
//  IntroViewController.swift
//  UIKitCatalog
//
//  Created by Philip Krück on 26.03.19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import APLVideoPlayerView

public protocol IntroViewControllerDelegate: NSObjectProtocol {
    func introViewControllerDidFinishPlayingVideo(_ controller: IntroViewController)
    func introViewControllerDidGetTapped(_ controller: IntroViewController)
    func introViewControllerVideoPlayerIsReadyToPlay(_ controller: IntroViewController)
}

open class IntroViewController: UIViewController {
    
    // MARK: public properties
    open weak var delegate: IntroViewControllerDelegate?
    open var imageName: String?
    open var videoName: String?
    open var videoFileExtension: String = ".mp4"
    open var canDismissViewControllerWithTouch = false
    open var videoDoesLoop = false
    open var configureForAmbientPlayback: Bool = true
    open var isStatusBarHidden = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    // MARK: private properties
    private var imageView: UIImageView!
    final private var videoPlayerView: APLVideoPlayerView!
    private static var keyValueObservationContext = 0
    
    override open var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        videoPlayerView.avPlayer.removeObserver(self, forKeyPath: "status", context: &IntroViewController.keyValueObservationContext)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        addImageView()
        addVideoPlayerView()
        
        if canDismissViewControllerWithTouch {
            addTapGestureRecognizer()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(videoDidFinishNotification(notification:)), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupVideoPlayer()
    }
    
    open func addImageView() {
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
    
    open func addVideoPlayerView() {
        videoPlayerView = APLVideoPlayerView()
        view.insertSubview(videoPlayerView, at: 1)
        
        // auto layout constraints
        videoPlayerView.translatesAutoresizingMaskIntoConstraints = false
        videoPlayerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        videoPlayerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        videoPlayerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        videoPlayerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    public func addTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTouchUpInsideScreen(sender:)))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    open func setupVideoPlayer() {
        if let videoFileName = videoName {
            if configureForAmbientPlayback {
                videoPlayerView.configureForAmbientPlayback()
            }

            videoPlayerView.setVideoFilename(videoFileName, withExtension: videoFileExtension, loop: videoDoesLoop)
            videoPlayerView.videoGravity = .resizeAspectFill
            videoPlayerView.avPlayer.actionAtItemEnd = .pause
            videoPlayerView.avPlayer.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions.new, context: &IntroViewController.keyValueObservationContext)
            videoPlayerView.play()
        }
    }
    
    @objc private func didTouchUpInsideScreen(sender: Any?) {
        delegate?.introViewControllerDidGetTapped(self)
    }
    
    @objc private func videoDidFinishNotification(notification: Notification) {
        delegate?.introViewControllerDidFinishPlayingVideo(self)
    }
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
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
