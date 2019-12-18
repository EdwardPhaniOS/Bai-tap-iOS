//
//  ViewController.swift
//  PlaySoundAndVideo
//
//  Created by iMac_VTCA on 12/16/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

//Bundle: Noi luu tru Resource for Build Time:
//Data/.../Documents: Noi luu tru du lieu at Run time. Vi du: Luc App download file mp3/mp4/pdf,... ve thi file se duoc luu o Data/.../Documents chu khong luu o Bundle
//Khong present/ push trong viewDidLoad vi luc do kha nang cao la mot so View chua Render xong

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var playerSlider: UISlider!
    
    private var player: AVAudioPlayer!
    
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        print("docPath: \(docPath)")
        
        guard let path = Bundle.main.path(forResource: "If_I_Had_a_Chicken", ofType: "mp3") else { return }
        
        print("path: \(path)")
        
        guard let url = URL(string: path) else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
        } catch let err {
            print("Init audioPlayer failed: \(err)")
        }
    }
    
    @IBAction func playPressed(_ sender: UIButton) {
        createProgressTimer()
        player.play()
    }
    
    @IBAction func pausePressed(_ sender: UIButton) {
        player.pause()
        
        if let timer = timer {
            timer.invalidate()
        }
    }
    
    @IBAction func stopPressed(_ sender: UIButton) {
        player.stop()
        
        if let timer = timer {
            timer.invalidate()
        }
    }

    @IBAction func sliderChanged(_ sender: UISlider) {
        
        let senderValue = Double(sender.value)
        let currentTime = player.duration * senderValue
        
        player.currentTime = currentTime
        
        createProgressTimer()
        player.play()
    }
    
    func createProgressTimer() {
        
        if !player.isPlaying {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                let currentProcess = Float(self.player.currentTime / self.player.duration)
                self.playerSlider.setValue(currentProcess, animated: true)
            }
        }
    }
    
}

