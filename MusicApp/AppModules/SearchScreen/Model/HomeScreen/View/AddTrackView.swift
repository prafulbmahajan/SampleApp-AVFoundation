//
//  AddTrackView.swift
//  MusicApp
//
//  Created by Praful Mahajan on 16/08/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit

struct AddOptions: Codable {
    var addIcon: String
    var addTitle: String
    var addDescription: String
}

class AddTrackView: UIView {
    static let ID = "AddTrackView"
    var addOption: [AddOptions] = []
    var callBack : ((AddOptions, Int)->Void)?

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.separatorStyle = .none
            self.tableView.register(UINib(nibName: TrackCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: TrackCell.cellIdentifier())
            self.tableView.register(UINib(nibName: AddTrackCell.ID, bundle: nil), forCellReuseIdentifier: AddTrackCell.ID)
        }
    }
    @IBOutlet weak var dismissAction: ActionButton!

    class func instanceFromNib() -> AddTrackView? {
        return UINib(nibName: AddTrackView.ID, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? AddTrackView
    }

    func initializeTheAddOptions(addIcon: String, addTitle: String, addDescription: String) {
        self.addOption.removeAll()
        let addOption1 = AddOptions(addIcon: addIcon, addTitle: addTitle, addDescription: addDescription)
        //let addOption2 = AddOptions(addIcon: "playNext", addTitle: "Play Next", addDescription: "")
        //let addOption3 = AddOptions(addIcon: "addToPlay", addTitle: "Add to Play Queue", addDescription: "")
        let addOption4 = AddOptions(addIcon: "addToPlist", addTitle: "Add to Playlist", addDescription: "")
        let addOption5 = AddOptions(addIcon: "favorite", addTitle: "Add to My Favorite Songs", addDescription: "")
        let addOption6 = AddOptions(addIcon: "share", addTitle: "Share", addDescription: "")
        addOption.append(addOption1)
        //addOption.append(addOption2)
        //addOption.append(addOption3)
        addOption.append(addOption4)
        addOption.append(addOption5)
        addOption.append(addOption6)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension AddTrackView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.addOption.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TrackCell.cellIdentifier(), for: indexPath) as! TrackCell
            cell.selectionStyle = .none
            let addOption = self.addOption[indexPath.row]
            cell.addbtn.isHidden = true
            cell.banerImage.image = UIImage(named: addOption.addIcon)
            cell.trackTitle.text = addOption.addTitle
            cell.detailTitle.text = addOption.addDescription
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: AddTrackCell.ID, for: indexPath) as! AddTrackCell
        cell.selectionStyle = .none
        let addOption = self.addOption[indexPath.row]
        cell.cellConfiguration(addOption: addOption)
        return cell
    }
}

extension AddTrackView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 80.0 : 44.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row > 0 {
            let addOption = self.addOption[0]
            self.callBack!(addOption, indexPath.row)
        }
    }
}


