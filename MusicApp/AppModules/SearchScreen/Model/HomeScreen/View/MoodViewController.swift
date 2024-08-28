//
//  MoodViewController.swift
//  MusicApp
//
//  Created by Praful Mahajan on 07/12/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit

class MoodViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.register(UINib(nibName: TrackCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: TrackCell.cellIdentifier())
        }
    }
    @IBOutlet weak var pageTitlelbl: UILabel!

    var titleStr: String?
    var playListType: PlayListType = .Genreshiphop
    var moodArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.pageTitlelbl.text = self.titleStr
        self.title = self.titleStr
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    @IBAction func backButtonDidClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MoodViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moodArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackCell.cellIdentifier(), for: indexPath) as! TrackCell
        cell.selectionStyle = .none
        let model = moodArray[indexPath.row]
        cell.cellMoodConfiguration(moodTxt: model)
        cell.trackCount.isHidden = true
        cell.trackCountWidth.constant = 0.0
        cell.trackCount.text = ""
        cell.addbtn.isHidden = true
        return cell
    }
}

extension MoodViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if playListType == .Genreshiphop {
            showGenresPlayList(row: indexPath.row)
        }
    }

    func showGenresPlayList(row: Int) {
        var playlistId = ""
        var titleTxt = "Search"
        switch row {
        case 0:
            playlistId = Generic.kYoutubeGenreshiphopPlaylistId
            titleTxt = "HIP-HOP"
            break
        case 1:
            playlistId = Generic.kYoutubeGenresPopPlaylistId
            titleTxt = "POP"
        default:
            break
        }
        if let vc = Generic.getViewControllerFromStoryBoard(type: SearchViewController.self, storyBoard: .TABS) {
            vc.titleTxt = titleTxt
            vc.playListType = .Genreshiphop
            vc.playlistId = playlistId
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
