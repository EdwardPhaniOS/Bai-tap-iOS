//
//  PlayVideoController.swift
//  PlaySoundAndVideo
//
//  Created by iMac_VTCA on 12/16/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class PlayVideoController: UIViewController {
    
    var vc: AVPlayerViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareVideo()
    }
    
    func prepareVideo() {
        
        //Lay url den file mp4
        guard let path = Bundle.main.path(forResource: "SampleVideo_1280x720_1mb", ofType: "mp4") else { return }
        
        let url = URL(fileURLWithPath: path)
        
        //Tao VC tu AVKit
        vc = AVPlayerViewController()
        
        //Gan player vao VC vua tao
        let player = AVPlayer(url: url)
        vc.player = player
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.present(vc, animated: true) {
            self.vc.player?.play()
        }
    }
    
}
