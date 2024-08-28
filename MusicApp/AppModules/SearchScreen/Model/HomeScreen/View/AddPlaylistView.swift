//
//  AddPlaylistView.swift
//  MusicApp
//
//  Created by Praful Mahajan on 17/08/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit

class AddPlaylistView: UIView {
    static let ID = "AddPlaylistView"
    var addOption: [AddOptions] = []
    var callBack : ((Playlist)->Void)?

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.separatorStyle = .none
            self.tableView.register(UINib(nibName: TrackCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: TrackCell.cellIdentifier())
        }
    }
    @IBOutlet weak var dismissAction: ActionButton!
    @IBOutlet weak var cancelAction: ActionButton!
    @IBOutlet weak var createAction: ActionButton!
    var playlists: [Playlist] = LocalStore.getPlaylist()

    class func instanceFromNib() -> AddPlaylistView? {
        return UINib(nibName: AddPlaylistView.ID, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? AddPlaylistView
    }

    func setInitialView(playList: [Playlist]) {
        self.playlists = playList
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension AddPlaylistView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackCell.cellIdentifier(), for: indexPath) as! TrackCell
        cell.selectionStyle = .none
        let playlist = self.playlists[indexPath.row]
        let count = self.playlists.count
        cell.trackTitle.text = playlist.name
        cell.detailTitle.text = "\(count) Songs"
        cell.banerImage.image = UIImage(named: "start_screen_logo")
        cell.addbtn.isHidden = true
        return cell
    }
}

extension AddPlaylistView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let playlist = self.playlists[indexPath.row]
        self.callBack?(playlist)
    }
}
