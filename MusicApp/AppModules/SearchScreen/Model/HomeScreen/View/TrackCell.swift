//
//  TrackCell.swift
//  MusicApp
//
//  Created by Praful Mahajan on 19/07/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit
import SDWebImage

class TrackCell: UITableViewCell {

    //**************************************************
    // MARK: - IBOutlets
    //**************************************************
    @IBOutlet weak var banerImage:DesignableImageView!
    @IBOutlet weak var trackTitle:UILabel!
    @IBOutlet weak var detailTitle:UILabel!
    @IBOutlet weak var addbtn:ActionButton!
    @IBOutlet weak var trackCount:UILabel!
    @IBOutlet weak var trackCountWidth:NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    static func cellIdentifier() -> String {
        return "TrackCell"
    }

    func cellConfiguration(index: Int) {
        switch index {
        case 0:
            self.trackTitle.text = "Time"
            self.detailTitle.text = "Pink Floyd / 6:54"
            break
        case 1:
            self.trackTitle.text = "Diamond Dogs"
            self.detailTitle.text = "David Bowie / 6:04"
            break
        case 2:
            self.trackTitle.text = "Bagrain"
            self.detailTitle.text = "The Who / 5:53"
            break
        case 3:
            self.trackTitle.text = "Peace of Mind"
            self.detailTitle.text = "Boston / 5:04"
            break
        case 4:
            self.trackTitle.text = "Stay With Me"
            self.detailTitle.text = "The Faces / 4:39"
            break
        case 5:
            self.trackTitle.text = "Blossom"
            self.detailTitle.text = "James Taylor / 2:14"
            break
        case 6:
            self.trackTitle.text = "L.A.Woman"
            self.detailTitle.text = "The Doors / 7:51"
            break
        case 7:
            self.trackTitle.text = "You're My Best Friend"
            self.detailTitle.text = "Queen / 2:41"
            break
        default:
            break
        }
    }

    func cellConfiguration(addOption: AddOptions) {
        self.trackTitle.text = addOption.addTitle
        self.detailTitle.text = addOption.addDescription
        self.banerImage.image = UIImage(named: addOption.addIcon)
    }

    func cellYoutubeConfiguration(index: Int, item: Item) {
        self.trackTitle.text = item.snippet?.title
        self.detailTitle.text = item.snippet?.channelTitle
        self.banerImage.sd_setImage(with: URL(string: item.snippet?.thumbnails?.thumbnailsDefault?.url ?? ""), placeholderImage: UIImage(named: "start_screen_logo"))
    }

    func cellYoutubeConfiguration(index: Int, item: VideoListModel) {
        self.trackTitle.text = item.name
        self.detailTitle.text = item.video_description
        self.banerImage.sd_setImage(with: URL(string: item.file ?? ""), placeholderImage: UIImage(named: "start_screen_logo"))
    }

    func cellYoutubeConfiguration(index: Int, items: Items) {
        self.trackTitle.text = items.snippet?.title
        self.detailTitle.text = items.snippet?.channelTitle
        self.banerImage.sd_setImage(with: URL(string: items.snippet?.thumbnails?.thumbnailsDefault?.url ?? ""), placeholderImage: UIImage(named: "start_screen_logo"))
    }

    func cellMoodConfiguration(moodTxt: String) {
        self.trackTitle.text = moodTxt
        self.detailTitle.text = ""
        self.banerImage.image = UIImage(named: "bg2")
    }
}
