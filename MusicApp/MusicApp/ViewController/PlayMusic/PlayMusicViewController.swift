//
//  PlayMusicViewController.swift
//  MusicApp
//
//  Created by Lauv Edward on 03/08/2021.
//

import UIKit
import MediaPlayer

@available(iOS 13.0, *)
class PlayMusicViewController: UIViewController {
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var singerLabel: UILabel!
    @IBOutlet weak var totaltimeLabel: UILabel!
    let volumeslider = (MPVolumeView().subviews.filter { NSStringFromClass($0.classForCoder) == "MPVolumeSlider" }.first as! UISlider)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func clickDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func setupUI() {
        self.view.backgroundColor = .grayColorMain
        guard let song = MusicController.share.song else {
            return
        }
        volumeSlider.value = AVAudioSession.sharedInstance().outputVolume
        let item: MPMediaItem = SongQuery().getItem(songId: song.songId)
        let duration = item.playbackDuration
        print(duration)
        let format = DateComponentsFormatter()
        format.allowedUnits = [.minute, .second]
        totaltimeLabel.text = format.string(from: duration)
        nameLabel.text = song.songTitle
        singerLabel.text = song.artistName
        if let imageSound: MPMediaItemArtwork = item.value(forProperty: MPMediaItemPropertyArtwork) as? MPMediaItemArtwork {
            avatarImageView.image = imageSound.image(at: CGSize(width: avatarImageView.frame.width, height: avatarImageView.frame.height))
        }
        
    }
    @IBAction func sliderVolumeChange(_ sender: UISlider) {
        volumeslider.setValue(sender.value, animated: false)
    }
    @IBAction func clickPlayButton(_ sender: Any) {
        if MusicController.share.isPlay {
            MusicController.share.pause()
            self.playButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        } else {
            MusicController.share.play()
            self.playButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        }        
    }
}
