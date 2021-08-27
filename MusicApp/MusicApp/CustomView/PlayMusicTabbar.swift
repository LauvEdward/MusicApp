//
//  PlayMusicTabbar.swift
//  MusicApp
//
//  Created by Lauv Edward on 24/08/2021.
//

import UIKit
import MediaPlayer
@available(iOS 13.0, *)
class PlayMusicTabbar: UIView {
    @IBOutlet weak var singerLabel: UILabel!
    @IBOutlet weak var nameSong: UILabel!
    @IBOutlet weak var imageSong: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var playButton: UIButton! {
        didSet {
            if (MusicController.share.isPlay) {
                playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            } else {
                playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
        setupView()
    }
    
    @IBAction func playMusic(_ sender: Any) {
        if MusicController.share.isPlay {
            MusicController.share.pause()
        } else {
            MusicController.share.play()
        }
    }
    
    func setupView() {
        Bundle.main.loadNibNamed("PlayMusicTabbar", owner: self, options: nil)
        self.addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.backgroundColor = .grayColorMain
        NotificationCenter.default.addObserver(self, selector: #selector(setupPlayMusic), name:Notification.Name.SetViewPlayMusic, object: nil)
    }
    @objc func setupPlayMusic() {
        guard let song = MusicController.share.song else {
            return
        }
        self.nameSong.text = song.songTitle
        self.singerLabel.text = song.artistName
        let item: MPMediaItem = SongQuery().getItem(songId: song.songId)
        if let imageSound: MPMediaItemArtwork = item.value(forProperty: MPMediaItemPropertyArtwork) as? MPMediaItemArtwork {
            imageSong.image = imageSound.image(at: CGSize(width: imageSong.frame.size.width, height: imageSong.frame.size.height))
        }
    }
}
