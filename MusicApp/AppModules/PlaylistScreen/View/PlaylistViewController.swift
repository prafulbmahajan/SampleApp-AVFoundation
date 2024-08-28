//
//  PlaylistViewController.swift
//  MusicApp
//
//  Created by Praful Mahajan on 18/08/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.separatorStyle = .none
            self.tableView.register(UINib(nibName: TrackCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: TrackCell.cellIdentifier())
        }
    }

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            self.activityIndicator.hidesWhenStopped = true
        }
    }

    var playlistViewModel = PlaylistViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.activityIndicator.startAnimating()
        self.playlistViewModel.callGetPlaylistAPI { (response, message) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
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

extension PlaylistViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.playlistViewModel.playlist.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackCell.cellIdentifier(), for: indexPath) as! TrackCell
        cell.selectionStyle = .none
        let playlist =  self.playlistViewModel.playlist[indexPath.row]
        let count = self.playlistViewModel.playlist.count//LocalStore.getPlaylistSongs(key: playlist).count
        cell.trackTitle.text = playlist.name
        cell.detailTitle.text = "Songs"
        cell.banerImage.image = UIImage(named: "start_screen_logo")
        cell.addbtn.isHidden = true
        return cell
    }
}

extension PlaylistViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let playlist = self.playlistViewModel.playlist[indexPath.row]
        if let vc = Generic.getViewControllerFromStoryBoard(type: LibraryViewController.self, storyBoard: .TABS) {
            vc.playlistId = playlist.id ?? -1
            //vc.playlistKey = playlist
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let deleteAction: UITableViewRowAction = UITableViewRowAction.init(style: .normal, title: "Delete") { [weak self] (action, indexPath) in
            let model = self?.playlistViewModel.playlist[indexPath.row]
            self?.playlistViewModel.playlist.remove(at: indexPath.row)
            let playlistId = model?.id ?? -1
            self?.activityIndicator.startAnimating()
            self?.playlistViewModel.deletePlaylist(playlistId: playlistId, isCompleted: { (response, message) in
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()
                    self?.showToast(withMessage: message) {
                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                        }
                    }
                }
            })
        }
        deleteAction.backgroundColor = .red

        return [deleteAction]
    }
}
