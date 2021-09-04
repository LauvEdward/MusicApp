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
    
    @IBOutlet weak var compoundView: CompoundView!
    @IBOutlet weak var timenowLabel: UILabel!
    @IBOutlet weak var playMusicSlider: UISlider!
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
    func setupCountDownTimer() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
    }
    @objc func updateSlider() {
        guard let song = MusicController.share.song else {
            return
        }
        let item: MPMediaItem = SongQuery().getItem(songId: song.songId)
        let duration = item.playbackDuration
        let timenow = MPMusicPlayerController.applicationMusicPlayer.currentPlaybackTime
        timenowLabel.text = timenow.convertToMinnuteAndSecond()
        print(Float(timenow*60)/Float(duration*60))
        self.playMusicSlider.value = (Float(timenow*60)/Float(duration*60))
    }
    func setupUI() {
        setupCountDownTimer()
        self.view.backgroundColor = .grayColorMain
        volumeSlider.value = AVAudioSession.sharedInstance().outputVolume
        guard let song = MusicController.share.song else {
            return
        }
        let item: MPMediaItem = SongQuery().getItem(songId: song.songId)
        let duration = item.playbackDuration
        totaltimeLabel.text = duration.convertToMinnuteAndSecond()
        nameLabel.text = song.songTitle
        singerLabel.text = song.artistName
        if let imageSound: MPMediaItemArtwork = item.value(forProperty: MPMediaItemPropertyArtwork) as? MPMediaItemArtwork {
            avatarImageView.image = imageSound.image(at: CGSize(width: avatarImageView.frame.width, height: avatarImageView.frame.height))
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickCompound))
        compoundView.addGestureRecognizer(tap)
        compoundView.isUserInteractionEnabled = true
        
    }
    @objc func clickCompound() {
        let compoundVC = CompoundViewController()
        compoundVC.modalPresentationStyle = .fullScreen
        self.present(compoundVC, animated: true, completion: nil)
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
