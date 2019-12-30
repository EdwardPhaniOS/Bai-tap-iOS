//
//  SongTableViewCell.swift
//  NewNetworking
//
//  Created by THAI LE QUANG on 12/23/19.
//  Copyright © 2019 THAI LE QUANG. All rights reserved.
//

import UIKit
import AVFoundation

protocol SongTableViewCellDelegate: class {
    func downloadTapped(_ cell: SongTableViewCell)
    func cancelTapped(_ cell: SongTableViewCell)
    func pauseTapped(_ cell: SongTableViewCell)
    func resumeTapped(_ cell: SongTableViewCell)
}

class SongTableViewCell: UITableViewCell, Cell {
    //
    //MARK: - Outlet
    //
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var downloadProgress: UIProgressView!
    @IBOutlet weak var percentLabel: UILabel!
    
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    //
    //MARK: - Variable, Constants
    //
    weak var delegate: SongTableViewCellDelegate?
    let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    var audioPlayer: AVAudioPlayer!
    
    //
    //MARK: - Handle Actions
    //
    @IBAction func downloadButton_clicked(_ sender: Any) {
        delegate?.downloadTapped(self)
    }
    
    @IBAction func pauseButtonPressed(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "Pause" {
            delegate?.pauseTapped(self)
            sender.setTitle("Resume", for: .normal)
            
        } else {
            delegate?.resumeTapped(self)
            sender.setTitle("Pause", for: .normal)
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        
        delegate?.cancelTapped(self)
        
        downloadButton.isHidden = false
        cancelButton.isHidden = true
        pauseButton.isHidden = true
        
        pauseButton.setTitle("Pause", for: .normal)
        
        downloadProgress.progress = 0
        percentLabel.text = "0% of 0.0 MB"
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        
        let playButton = sender as! UIButton
      
        if !audioPlayer.isPlaying {
            playButton.setImage(UIImage(systemName: "pause.circle"), for: .normal)
            audioPlayer.play()
            
        } else {
            playButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
            audioPlayer.pause()
        }
    }
    
    //
    //MARK: - Display cell
    //
    func visualizeCell(with track: Track, download: Download?) {
        
        songNameLabel.text = track.name
        artistLabel.text = track.artist
        
        if download?.track.isDownloaded ?? false {
            downloadButton.isHidden = true
            pauseButton.isHidden = true
            cancelButton.isHidden = true
            percentLabel.isHidden = true
            downloadProgress.isHidden = true
            playButton.isHidden = false
            
            createAudioPlayer(with: track)
            
        } else {
            downloadButton.isHidden = false
            pauseButton.isHidden = true
            cancelButton.isHidden = true
            percentLabel.isHidden = false
            downloadProgress.isHidden = false
            
            downloadProgress.progress = 0
            
            percentLabel.text = "0% of 0.0 MB"
        }
    }
    
    private func createAudioPlayer(with track: Track) {
        if audioPlayer == nil {
            let lastPathComponent = track.previewURL.lastPathComponent
            let audioURL = documentsPath.appendingPathComponent(lastPathComponent)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
                audioPlayer.delegate = self
            } catch {
                print("Init audioPlayer failed: \(error)")
            }
        }
    }
    
    func updateDisplay(progress: Float, totalSize : String, download: Download) {
        
        downloadProgress.progress = progress
        percentLabel.text = String(format: "%.1f%% of %@", progress * 100, totalSize)
        
        if download.isDownloading {
            downloadButton.isHidden = true
            pauseButton.isHidden = false
            cancelButton.isHidden = false
            
        } else {
            downloadButton.isHidden = true
            pauseButton.isHidden = false
            cancelButton.isHidden = false
        }
    }
}

extension SongTableViewCell: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        if flag {
            playButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        }
    }
}
