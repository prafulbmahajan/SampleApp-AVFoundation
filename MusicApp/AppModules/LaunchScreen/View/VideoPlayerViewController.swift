//
//  VideoPlayerViewController.swift
//  MusicApp
//
//  Created by Praful Mahajan on 06/10/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class VideoPlayerViewController: UIViewController {

    @IBOutlet var videoPlayer: YTPlayerView! {
        didSet {
            self.videoPlayer.backgroundColor = .clear
        }
    }
    var videoID: String = ""
    var playListAPI: String = Generic.kYoutubeMainPlaylistAPI

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPlayer()
    }

    func loadPlayer() {
        videoPlayer.delegate = self
        videoPlayer.load(withVideoId: videoID)
    }
}

extension VideoPlayerViewController: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}
