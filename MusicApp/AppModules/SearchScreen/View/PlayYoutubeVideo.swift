//
//  PlayYoutubeVideo.swift
//  MusicApp
//
//  Created by Praful Mahajan on 26/07/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import Foundation
import WebKit

class PlayYoutubeVideo: UIViewController {

    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var backButton: ActionButton! {
        didSet {
            backButton.touchUp = { button in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }

    var videoID: String = ""
    var playListAPI: String = Generic.kYoutubeMainPlaylistAPI

    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()
    }

    fileprivate func loadWebView() {
        self.activityIndicator.startAnimating()
        self.activityIndicator.hidesWhenStopped = true
        guard let youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(videoID)&list=\(playListAPI)") else {
        return
        }
        webView.load(URLRequest(url: youtubeURL))
    }
}

extension PlayYoutubeVideo: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}
