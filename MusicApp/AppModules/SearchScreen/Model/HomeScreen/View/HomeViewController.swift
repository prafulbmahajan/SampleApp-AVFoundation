//
//  HomeViewController.swift
//  MusicApp
//
//  Created by Praful Mahajan on 19/07/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import HCVimeoVideoExtractor

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.separatorStyle = .none
            self.tableView.register(UINib(nibName: HeaderView.cellIdentifier(), bundle: nil), forHeaderFooterViewReuseIdentifier: HeaderView.cellIdentifier())
            self.tableView.register(UINib(nibName: TrendingCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: TrendingCell.cellIdentifier())
            self.tableView.register(UINib(nibName: RecentlyPlayedCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: RecentlyPlayedCell.cellIdentifier())
            self.tableView.register(UINib(nibName: GenresCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: GenresCell.cellIdentifier())
            self.tableView.register(UINib(nibName: MoodsCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: MoodsCell.cellIdentifier())
            self.tableView.register(UINib(nibName: TrackCell.cellIdentifier(), bundle: nil), forCellReuseIdentifier: TrackCell.cellIdentifier())
        }
    }
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentController: UISegmentedControl!

    var resultSearchController = UISearchController()
    let addTrackView: AddTrackView? = AddTrackView.instanceFromNib()
    let addPlaylistView: AddPlaylistView? = AddPlaylistView.instanceFromNib()
    let createPlaylistView: CreatePlaylistView? = CreatePlaylistView.instanceFromNib()
    var youtubeSearchModel: YoutubeSearchModel?
    var items: [Items] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        self.segmentController.selectedSegmentIndex = LocalStore.getSelectedSegment()
    }

    func setUpSearchBar() {
        self.resultSearchController = ({
            let searchController = UISearchController(searchResultsController: nil)
            searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.placeholder = "Search"
            searchController.searchBar.tintColor = .white
            //searchController.searchBar.setImage(UIImage(named: "whiteSearch"), for: UISearchBar.Icon.search, state: .normal)
            //searchController.searchBar.setImage(UIImage(named: "whiteCancel"), for: UISearchBar.Icon.clear, state: .normal)
            searchController.searchBar.set(textColor: .black)
            searchController.searchBar.setTextField(color: .black)
            searchController.searchBar.setPlaceholder(textColor: .black)
            searchController.searchBar.setSearchImage(color: .black)
            searchController.searchBar.setClearButton(color: .black)
            searchController.searchBar.barTintColor = .black
            self.navigationItem.searchController = searchController
            self.navigationItem.hidesSearchBarWhenScrolling = false
            return searchController
        })()
    }

    func showGenresPlayList(row: Int, playListType: PlayListType) {
        var playlistId = ""
        var titleTxt = "Search"
        switch row {
        case 0:
            playlistId = Generic.kYoutubeGenreshiphopPlaylistId
            titleTxt = playListType == .Genreshiphop ? "HIP-HOP" : "PARTY"
            break
        case 1:
            playlistId = Generic.kYoutubeGenresPopPlaylistId
            titleTxt = playListType == .Genreshiphop ? "POP" : "CHILL"
        case 2:
            titleTxt = playListType == .Genreshiphop ? "HYPHY" : "FRANTIC"
        case 3:
            titleTxt = playListType == .Genreshiphop ? "JAZZ%20RAP" : "ENERGETIC"
        case 4:
            titleTxt = playListType == .Genreshiphop ? "LATIN%20JAZZ" : "ANXIOUS/SAD"
        default:
            break
        }
        if let vc = Generic.getViewControllerFromStoryBoard(type: SearchViewController.self, storyBoard: .TABS) {
            vc.titleTxt = titleTxt
            vc.playListType = playListType
            vc.playlistId = playlistId
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    @IBAction func segmentController(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            LocalStore.setSelectedSegment(segment: 0)
        } else {
            LocalStore.setSelectedSegment(segment: 1)
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
        case 1: //Play Next
            break
        case 2: //Add to Play Queue
            break
        case 3: //Add to Playlist
            if LocalStore.getPlaylist().count > 0 {
                self.showAddToPlaylistView(addOption: addOption)
                return
            }
            self.showCreatePlaylistView(addOption: addOption)

            break
        case 4: //Add to My Favorite Songs
            var favoriteList = LocalStore.getFavorites()
            let addedOnly = favoriteList.filter({ $0.addTitle.lowercased() == addOption.addTitle.lowercased() })
            if addedOnly.count <= 0 {
                favoriteList.append(addOption)
                LocalStore.setFavorites(favoriteTrack: favoriteList)
            }
            self.showToast(withMessage: "Added successfully!!!")
            break
        case 5: //Share
            self.shareTheTrack()
            break
        default:
            break
        }
    }

    func showAddToPlaylistView(addOption: AddOptions) {
        Generic.removeFromSuperView(view: self.addPlaylistView)
        guard let addPlaylistView = self.addPlaylistView else { return }
        addPlaylistView.setInitialView(playList: [])
        addPlaylistView.callBack = { playlistName in
            Generic.removeFromSuperView(view: addPlaylistView)
//            var songList = LocalStore.getPlaylistSongs(key: playlistName)
//            songList.append(addOption)
//            LocalStore.setPlaylistSongs(tracks: songList, key: playlistName)
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
            var playlists = LocalStore.getPlaylist()
            let playlist = Playlist.init(id: -1, name: txt, is_subscribed: 0, playlist_description: nil, image_url: nil)
            playlists.append(playlist)
            LocalStore.setPlaylist(playlistName: playlists)
            var songList = LocalStore.getPlaylistSongs(key: txt)
            songList.append(addOption)
            LocalStore.setPlaylistSongs(tracks: songList, key: txt)
            Generic.removeFromSuperView(view: createPlaylistView)
        }
        Generic.addToSubView(view: createPlaylistView)
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

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.resultSearchController.isActive {
            return 1
        }
        return 5
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.resultSearchController.isActive {
            return self.items.count
        }
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 1
        case 4:
            return 8
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.resultSearchController.isActive {
            let cell = tableView.dequeueReusableCell(withIdentifier: TrackCell.cellIdentifier(), for: indexPath) as! TrackCell
            cell.selectionStyle = .none
            if self.items.count > 0 {
                let model = self.items[indexPath.row]
                cell.cellYoutubeConfiguration(index: indexPath.row, items: model)
                cell.trackCount.isHidden = true
                cell.trackCountWidth.constant = 0.0
                cell.trackCount.text = ""
                cell.addbtn.isHidden = true
            }
            return cell
        }
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: TrendingCell.cellIdentifier(), for: indexPath) as! TrendingCell
            cell.selectionStyle = .none
            cell.cellConfiguration(index: indexPath.row)
            cell.callBack = { row in
                if LocalStore.getSelectedSegment() == 0 {
                    self.openPlayerView()
                } else {
                    self.openVimeoVideo(index: row!)
                }
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: RecentlyPlayedCell.cellIdentifier(), for: indexPath) as! RecentlyPlayedCell
            cell.selectionStyle = .none
            cell.cellConfiguration(index: indexPath.row)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: GenresCell.cellIdentifier(), for: indexPath) as! GenresCell
            cell.selectionStyle = .none
            cell.cellConfiguration(index: indexPath.row)
            cell.callBack = { row in
                guard let row = row else { return }
                self.showGenresPlayList(row: row, playListType: .Genreshiphop)
            }
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: MoodsCell.cellIdentifier(), for: indexPath) as! MoodsCell
            cell.selectionStyle = .none
            cell.cellConfiguration(index: indexPath.row)
            cell.callBack = { row in
                guard let row = row else { return }
                self.showGenresPlayList(row: row, playListType: .Moods)
            }
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: TrackCell.cellIdentifier(), for: indexPath) as! TrackCell
            cell.selectionStyle = .none
            cell.cellConfiguration(index: indexPath.row)
            cell.addbtn.touchUp = { button in
                let addIcon: UIImage = cell.banerImage.image ?? UIImage()
                let addTitle: String = cell.trackTitle.text ?? ""
                let addDescription: String = cell.detailTitle.text ?? ""
                self.showAddTrackOption(addIcon: addIcon, addTitle: addTitle, addDescription: addDescription)
            }
            return cell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.resultSearchController.isActive {
            return nil
        }
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.cellIdentifier()) as! HeaderView
        headerView.cellConfiguration(index: section)
        headerView.seeAllAction.touchUp = { button in
            var titleTxt: String = "Moods"
            var moodsArray: [String] = []
            var playListType: PlayListType = .Genreshiphop
            switch section {
            case 0:
                titleTxt = "Trending"
                break
            case 1:
                titleTxt = "Recently played"
                break
            case 2:
                titleTxt = "Genres"
                moodsArray = ["HIP-HOP", "POP", "HYPHY", "JAZZ RAP", "LATIN JAZZ"]
                playListType = .Genreshiphop
                break
            case 3:
                titleTxt = "Moods"
                moodsArray = ["PARTY", "CHILL", "FRANTIC", "ENERGETIC", "ANXIOUS/SAD"]
                playListType = .MainPlayList
                break
            case 4:
                titleTxt = "Most Playing Tracks"
                break
            default:
                titleTxt = "Moods"
                break
            }
            if let vc = Generic.getViewControllerFromStoryBoard(type: MoodViewController.self, storyBoard: .TABS) {
                vc.titleStr = titleTxt
                vc.moodArray = moodsArray
                vc.playListType = playListType
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        return headerView
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.resultSearchController.isActive {
            return 86.0
        }
        switch indexPath.section {
        case 0:
            return 200
        case 1:
            return 164
        case 2:
            return 96
        case 3:
            return 96
        case 4:
            return 86
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.resultSearchController.isActive {
            return 0.0
        }
        return 64
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if self.resultSearchController.isActive {
            let item = self.items[indexPath.row]
            if let vc = Generic.getViewControllerFromStoryBoard(type: VideoPlayerViewController.self, storyBoard: .MAIN) {
                vc.videoID = item.id?.videoID ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return
        }
        if indexPath.section == 4 {
            self.playAudioSongs()
        }
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if (searchController.searchBar.text?.count ?? 0) > 2 {
            self.getYoutubePlaylistFromChannel(searchTxt: searchController.searchBar.text!) { (response) in
                DispatchQueue.main.async {
                    if response {
                        self.tableView.reloadData()
                    }
                }
            }
            return
        }
        DispatchQueue.main.async {
            self.items.removeAll()
            self.tableView.reloadData()
        }
    }




    func getYoutubePlaylistFromChannel(searchTxt: String, complete: @escaping (Bool)-> Void) {
        let searchTxt = searchTxt.replacingOccurrences(of: " ", with: "%20")
        let urlString = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=\(searchTxt)&type=video&maxResults=25&key=\(Generic.kYoutubeAPIKey)"
        let apiConfiguration = APIConfiguration(baseUrl: urlString, httpMethod: .get)
        let configuration = apiConfiguration.configuration()
        let session = URLSession(configuration: configuration)

        if let url = URL.init(string: urlString) {
            let urlRequest = URLRequest.init(url: url)
            session.dataTask(with: urlRequest) { (data, response, error) in
                if let data = data {
                    if let json = String(data: data, encoding: String.Encoding.utf8) {
                        print("*** Response Json *** \n\(json)")
                        let jsonData = Data(json.utf8)
                        let decoder = JSONDecoder()
                        self.youtubeSearchModel = try? decoder.decode(YoutubeSearchModel.self, from: jsonData)
                        self.items = self.youtubeSearchModel?.items ?? []
                        complete(true)
                    }
                    else {
                        complete(false)
                    }
                }
                else {
                    complete(false)
                }
            }.resume()
        }
    }
}

extension HomeViewController {
    func openPlayerView() {
        if let videoFilePath = Bundle.main.path(forResource: "video", ofType: "mp4") {
            let url = URL(fileURLWithPath: videoFilePath)
            let player = AVPlayer(url: url)
            player.isMuted = false
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            playerViewController.player?.isMuted = false
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        }
    }

    func openVimeoVideo(index: Int) {
        var url = URL(string: "https://player.vimeo.com/video/459078330")!
        if index == 1 {
            url = URL(string: "https://player.vimeo.com/video/467211493")!
        } else if index == 2 {
            url = URL(string: "https://player.vimeo.com/video/467216083")!
        }
        HCVimeoVideoExtractor.fetchVideoURLFrom(url: url, completion: { ( video:HCVimeoVideo?, error:Error?) -> Void in
            DispatchQueue.main.async {
                if let err = error {
                   print("Error = \(err.localizedDescription)")
                   return
                }

                guard let vid = video else {
                    print("Invalid video object")
                    return
                }

                print("Title = \(vid.title), url = \(vid.videoURL), thumbnail = \(vid.thumbnailURL)")

                if let videoURL = vid.videoURL[.Quality540p] {
                    let player = AVPlayer(url: videoURL)
                    let playerController = AVPlayerViewController()
                    playerController.player = player
                    self.present(playerController, animated: true) {
                        player.play()
                    }
                }
            }
        })
    }

    func playAudioSongs() {
        if let vc = Generic.getViewControllerFromStoryBoard(type: PlayerViewController.self, storyBoard: .MAIN) {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
