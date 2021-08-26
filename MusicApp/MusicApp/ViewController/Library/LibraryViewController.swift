import UIKit
import AVFoundation
import MediaPlayer

class LibraryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentView: UIView!
    var albums: [AlbumInfo] = []
    var songQuery: SongQuery = SongQuery()
    var audio: AVAudioPlayer?
    let mPMediaQuery = MPMediaQuery.songs()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("list song: \(mPMediaQuery)")
        setupUI()
        fetchData()
    }
    
    func setupUI() {
        contentView.backgroundColor = UIColor(hexFromString: "#17191A")
        tableView.register(UINib(nibName: "MusicPlayerCell", bundle: nil), forCellReuseIdentifier: "MusicPlayerCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func fetchData() {
        MPMediaLibrary.requestAuthorization { (status) in
            if status == .authorized {
                self.albums = self.songQuery.get(songCategory: "")
                DispatchQueue.main.async {
                    self.tableView?.rowHeight = UITableView.automaticDimension
                    self.tableView?.estimatedRowHeight = 60.0;
                    self.tableView?.reloadData()
                }
            } else {
                self.displayMediaLibraryError()
            }
        }
    }
    func displayMediaLibraryError() {
        
        var error: String
        switch MPMediaLibrary.authorizationStatus() {
        case .restricted:
            error = "Media library access restricted by corporate or parental settings"
        case .denied:
            error = "Media library access denied by user"
        default:
            error = "Unknown error"
        }
        
        let controller = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        controller.addAction(UIAlertAction(title: "Open Settings", style: .default, handler: { (action) in
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
            }
        }))
        present(controller, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
}

extension LibraryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return albums.count
    }
    
    func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int ) -> Int  {
        
        return albums[section].songs.count
    }
    
    func tableView( _ tableView: UITableView, cellForRowAt indexPath:IndexPath ) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "MusicPlayerCell",
            for: indexPath) as! MusicPlayerCell
        cell.labelMusicTitle?.text = albums[indexPath.section].songs[indexPath.row].songTitle
        cell.labelMusicDescription?.text = albums[indexPath.section].songs[indexPath.row].artistName
        let songId: NSNumber = albums[indexPath.section].songs[indexPath.row].songId
        let item: MPMediaItem = songQuery.getItem( songId: songId )
        
        if  let imageSound: MPMediaItemArtwork = item.value( forProperty: MPMediaItemPropertyArtwork ) as? MPMediaItemArtwork {
            cell.imageMusic?.image = imageSound.image(at: CGSize(width: cell.imageMusic.frame.size.width, height: cell.imageMusic.frame.size.height))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return albums[section].albumTitle
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let songId: NSNumber = albums[indexPath.section].songs[indexPath.row].songId
        let item: MPMediaItem = songQuery.getItem( songId: songId )
        do {
//            var player = MPMusicPlayerController.applicationMusicPlayer

            //Set a song
            MusicController.share.setQueue(songid: songQuery.get( songId: songId ))

            //Allow the song to play
            MusicController.share.play()
            
            MusicController.share.setSong(song: albums[indexPath.section].songs[indexPath.row])
            let notification = Notification(name: .SetViewPlayMusic, object: nil, userInfo: nil)
            NotificationCenter.default.post(notification)
        } catch let error {
            print(error.localizedDescription)
        }
        
        self.title = albums[indexPath.section].songs[indexPath.row].songTitle
    }
}
