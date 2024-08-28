//
//  SearchViewController.swift
//  MusicApp
//
//  Created by Praful Mahajan on 26/07/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.register(UINib(nibName: TrackCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: TrackCell.cellIdentifier())
        }
    }

    var searchViewModel = SearchViewModel()
    var playListType: PlayListType = .MainPlayList
    var playlistId: String = ""
    var titleTxt: String = ""
    let addTrackView: AddTrackView? = AddTrackView.instanceFromNib()
    let createPlaylistView: CreatePlaylistView? = CreatePlaylistView.instanceFromNib()
    let addPlaylistView: AddPlaylistView? = AddPlaylistView.instanceFromNib()
    let playlistViewModel: PlaylistViewModel = PlaylistViewModel()
    var videoId: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchViewModel.videoType = self.titleTxt
        self.title = self.titleTxt.replacingOccurrences(of: "%20", with: " ")
        self.getYoutubePlaylist()
    }

    func getYoutubePlaylist() {
        switch playListType {
        case .MainPlayList:
            self.searchViewModel.getYoutubePlaylistFromChannel { (response) in
                if response {
                    self.tableView.reloadData()
                }
            }
            break
        case .MainSubPlayList:
            self.searchViewModel.getYoutubePlaylistVideos(playListAPI: playlistId) { (response) in
                if response {
                    self.tableView.reloadData()
                }
            }
            break
        case .Genreshiphop:
            getVideoList()
            break
        case .Moods:
            getVideoList()
            break
        }
    }

    func getVideoList() {
        self.searchViewModel.getVideosByChoose { (response, message) in
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

    func showAddTrackOption(addIcon: UIImage, addTitle: String, addDescription: String) {
        Generic.removeFromSuperView(view: self.addTrackView)
        guard let addTrackView = self.addTrackView else { return }
        addTrackView.initializeTheAddOptions(addIcon: "start_screen_logo", addTitle: addTitle, addDescription: addDescription)
        addTrackView.callBack = { [weak self] (addOption, row) in
            Generic.removeFromSuperView(view: addTrackView)
            self?.performActionOnAddOptionSelection(addOption: addOption, row: row)
        }
        addTrackView.dismissAction.touchUp = { button in
            Generic.removeFromSuperView(view: addTrackView)
        }
        Generic.addToSubView(view: addTrackView)
    }

    func performActionOnAddOptionSelection(addOption: AddOptions, row: Int) {
        switch row {
        case 1:
            playlistViewModel.callGetPlaylistAPI { (response, message) in
                DispatchQueue.main.async {
                    if response && self.playlistViewModel.playlist.count > 0 {
                        self.showAddToPlaylistView(addOption: addOption)
                    } else {
                        self.showCreatePlaylistView(addOption: addOption)
                    }
                }
            }
            break
        case 2: //Add to My Favorite Songs
            var favoriteList = LocalStore.getFavorites()
            let addedOnly = favoriteList.filter({ $0.addTitle.lowercased() == addOption.addTitle.lowercased() })
            if addedOnly.count <= 0 {
                favoriteList.append(addOption)
                LocalStore.setFavorites(favoriteTrack: favoriteList)
            }
            self.showToast(withMessage: "Added successfully!!!")
            break
        case 3: //Share
            self.shareTheTrack()
            break
        default:
            break
        }
    }

    func showAddToPlaylistView(addOption: AddOptions) {
        Generic.removeFromSuperView(view: self.addPlaylistView)
        guard let addPlaylistView = self.addPlaylistView else { return }
        addPlaylistView.setInitialView(playList: self.playlistViewModel.playlist)
        addPlaylistView.callBack = { playlistName in
            Generic.removeFromSuperView(view: addPlaylistView)
            self.addToPlaylist(videoId: self.videoId, playlistId: playlistName.id ?? -1)
        }
        addPlaylistView.dismissAction.touchUp = { button in
            Generic.removeFromSuperView(view: addPlaylistView)
        }
        addPlaylistView.cancelAction.touchUp = { button in
            Generic.removeFromSuperView(view: addPlaylistView)
        }
        addPlaylistView.createAction.touchUp = { button in
            Generic.removeFromSuperView(view: addPlaylistView)
            self.showCreatePlaylistView(addOption: addOption)
        }
        Generic.addToSubView(view: addPlaylistView)
    }

    func showCreatePlaylistView(addOption: AddOptions) {
        Generic.removeFromSuperView(view: self.createPlaylistView)
        guard let createPlaylistView = self.createPlaylistView else { return }
        createPlaylistView.txtField.text = ""
        createPlaylistView.dismissAction.touchUp = { button in
            Generic.removeFromSuperView(view: createPlaylistView)
        }
        createPlaylistView.cancelAction.touchUp = { button in
            Generic.removeFromSuperView(view: createPlaylistView)
        }
        createPlaylistView.createAction.touchUp = { button in
            let txt = createPlaylistView.txtField.text ?? ""
            self.searchViewModel.createPlayList(playlistName: txt) { (response, message) in
                DispatchQueue.main.async {
                    self.showToast(withMessage: message) {
                        Generic.removeFromSuperView(view: createPlaylistView)
                        if response {
                            self.addToPlaylist(videoId: self.videoId, playlistId: self.searchViewModel.createPlaylistResponseModel?.id ?? -1)
                        }
                    }
                }
            }

        }
        Generic.addToSubView(view: createPlaylistView)
    }

    func addToPlaylist(videoId: String, playlistId: Int) {
        self.searchViewModel.addSongsToPlaylist(videoId: videoId, playListId: playlistId) { (response, message) in
            DispatchQueue.main.async {
                
            }
        }
    }

    func shareTheTrack() {
        // Setting description
        let firstActivityItem = "Share this track"

        // Setting url
        let secondActivityItem : NSURL = NSURL(string: "http://your-url.com/")!

        // If you want to use an image
        let image : UIImage = UIImage(named: "start_screen_logo")!
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)

        // This lines is for the popover you need to show in iPad
        //activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)

        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)

        // Pre-configuring activity items
        activityViewController.activityItemsConfiguration = [
        UIActivity.ActivityType.message
        ] as? UIActivityItemsConfigurationReading

        // Anything you want to exclude
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo,
            UIActivity.ActivityType.postToFacebook
        ]

        activityViewController.isModalInPresentation = true
        self.present(activityViewController, animated: true, completion: nil)
    }
}



extension SearchViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return playListType == .MainPlayList ? searchViewModel.items.count : playListType == .MainSubPlayList ? searchViewModel.items.count : searchViewModel.videoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackCell.cellIdentifier(), for: indexPath) as! TrackCell
        cell.selectionStyle = .none
        if playListType == .MainPlayList || playListType == .MainSubPlayList {
            let model = searchViewModel.items[indexPath.row]
            cell.cellYoutubeConfiguration(index: indexPath.row, item: model)
        } else {
            let model = searchViewModel.videoList[indexPath.row]
            cell.cellYoutubeConfiguration(index: indexPath.row, item: model)
        }
        cell.trackCount.isHidden = playListType != .MainPlayList
        cell.trackCountWidth.constant = playListType == .MainPlayList ? 21.0 : 0.0
        cell.trackCount.text = "5"
        cell.addbtn.isHidden = playListType == .MainPlayList
        cell.addbtn.touchUp = { button in
            if self.playListType == .MainPlayList || self.playListType == .MainSubPlayList {
                let model = self.searchViewModel.items[indexPath.row]
                self.videoId = model.snippet?.resourceID?.videoID ?? ""
            } else {
                let model = self.searchViewModel.videoList[indexPath.row]
                self.videoId = Generic.returnVideoId(videoListModel: model)
            }
            let addIcon: UIImage = cell.banerImage.image ?? UIImage()
            let addTitle: String = cell.trackTitle.text ?? ""
            let addDescription: String = cell.detailTitle.text ?? ""
            self.showAddTrackOption(addIcon: addIcon, addTitle: addTitle, addDescription: addDescription)
        }
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch playListType {
        case .MainPlayList:
            let item = searchViewModel.items[indexPath.row]
            let playlistId = item.id ?? ""
            if let vc = Generic.getViewControllerFromStoryBoard(type: SearchViewController.self, storyBoard: .TABS) {
                vc.playListType = .MainSubPlayList
                vc.playlistId = playlistId
                self.navigationController?.pushViewController(vc, animated: true)
            }
            break
        case .MainSubPlayList:
            let item = searchViewModel.items[indexPath.row]
            if let vc = Generic.getViewControllerFromStoryBoard(type: VideoPlayerViewController.self, storyBoard: .MAIN) {
                vc.videoID = item.snippet?.resourceID?.videoID ?? ""
                vc.playListAPI = item.snippet?.playlistID ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }
            break
        case .Genreshiphop, .Moods:
            let item = searchViewModel.videoList[indexPath.row]
            if let vc = Generic.getViewControllerFromStoryBoard(type: VideoPlayerViewController.self, storyBoard: .MAIN) {
                vc.videoID = Generic.returnVideoId(videoListModel: item)
                //vc.playListAPI = item.snippet?.playlistID ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }
            /*if let vc = Generic.getViewControllerFromStoryBoard(type: PlayYoutubeVideo.self, storyBoard: .SEARCH) {
                vc.videoID = item.snippet?.resourceID?.videoID ?? ""
                vc.playListAPI = item.snippet?.playlistID ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }*/
            break
        }
    }
}
