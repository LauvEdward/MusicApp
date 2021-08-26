//
//  MusicController.swift
//  MusicApp
//
//  Created by Lauv Edward on 16/08/2021.
//

import Foundation
import MediaPlayer
class MusicController {
    var song: SongInfo?
    static let share = MusicController()
    private var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    var isPlay: Bool = false
    func setQueue(songid: MPMediaQuery) {
        musicPlayer.setQueue(with: songid)
    }
    func play() {
        isPlay = true
        self.musicPlayer.prepareToPlay()
        self.musicPlayer.play()
    }
    
    func pause() {
        isPlay = false
        self.musicPlayer.pause()
    }
    
    func setSong(song: SongInfo) {
        self.song = song
    }
}
