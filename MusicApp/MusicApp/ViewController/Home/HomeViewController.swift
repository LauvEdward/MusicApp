//
//  HomeViewController.swift
//  MusicApp
//
//  Created by Lauv Edward on 24/07/2021.
//

import UIKit
import MediaPlayer
import StoreKit

protocol callbackTabbar {
    func callback()
}

class HomeViewController: UIViewController {

    var delegate: callbackTabbar!
    var player = AVAudioPlayer()
    private var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .grayColorMain
//        guard let url = Bundle.main.url(forResource: "song", withExtension: "mp3") else {
//            return
//        }
//        do {
//            player = try AVAudioPlayer(contentsOf: url)
//            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
//
//        } catch let err {
//            print(err.localizedDescription)
//        }
    }

    @IBAction func click(_ sender: Any) {
        delegate.callback()
//        player.play()
        
    }
    @IBAction func pause(_ sender: Any) {
//        player.pause()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//key id P6S3A9VWV9
