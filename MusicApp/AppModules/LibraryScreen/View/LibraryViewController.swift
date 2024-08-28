//
//  LibraryViewController.swift
//  MusicApp
//
//  Created by Praful Mahajan on 16/08/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.separatorStyle = .none
            self.tableView.register(UINib(nibName: TrackCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: TrackCell.cellIdentifier())
        }
    }
    var favoriteList: [AddOptions] = []
    var playlistId: Int = -1
    var playlistTitle: String = ""
    var libraryViewModel = LibraryViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = playlistId == -1 ? "Library" : playlistTitle
        self.favoriteList = LocalStore.getFavorites()
        if playlistId != -1 {
            self.getSongsOfPlaylist()
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func getSongsOfPlaylist() {
        self.libraryViewModel.getSongsByPlaylist(playlistId: self.playlistId) { (response, message) in
            DispatchQueue.main.async {
                self.showToast(withMessage: message) {
                    if response {
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
}

extension LibraryViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlistId == -1 ? self.favoriteList.count : self.libraryViewModel.videoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackCell.cellIdentifier(), for: indexPath) as! TrackCell
        cell.selectionStyle = .none
        if playlistId == -1 {
            let addOption = self.favoriteList[indexPath.row]
            cell.cellConfiguration(addOption: addOption)
        } else {
            let model = self.libraryViewModel.videoList[indexPath.row]
            cell.cellYoutubeConfiguration(index: indexPath.row, item: model)
        }
        cell.addbtn.isHidden = true
        return cell
    }
}

extension LibraryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let deleteAction: UITableViewRowAction = UITableViewRowAction.init(style: .normal, title: "Delete") { [weak self] (action, indexPath) in
            if self?.playlistId == -1 {
                self?.favoriteList.remove(at: indexPath.row)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } else {
                let model = self?.libraryViewModel.videoList[indexPath.row]
                self?.libraryViewModel.videoList.remove(at: indexPath.row)
                let videoId = Generic.returnVideoId(videoListModel: model!)
                self?.libraryViewModel.deleteSongsFromPlaylist(playlistId: self?.playlistId ?? -1, videoId: videoId, isCompleted: { (response, message) in
                    DispatchQueue.main.async {
                        self?.showToast(withMessage: message) {
                            DispatchQueue.main.async {
                                self?.tableView.reloadData()
                            }
                        }
                    }
                })
            }
        }
        deleteAction.backgroundColor = .red

        return [deleteAction]
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.libraryViewModel.videoList[indexPath.row]
        if let vc = Generic.getViewControllerFromStoryBoard(type: VideoPlayerViewController.self, storyBoard: .MAIN) {
            vc.videoID = Generic.returnVideoId(videoListModel: item)
            //vc.playListAPI = item.snippet?.playlistID ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
