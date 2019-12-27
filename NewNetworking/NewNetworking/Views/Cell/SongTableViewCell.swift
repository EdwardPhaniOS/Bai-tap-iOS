//
//  SongTableViewCell.swift
//  NewNetworking
//
//  Created by THAI LE QUANG on 12/23/19.
//  Copyright © 2019 THAI LE QUANG. All rights reserved.
//

import UIKit

protocol SongTableViewCellDelegate: class {
    func downloadTapped(_ cell: SongTableViewCell)
    func cancelTapped(_ cell: SongTableViewCell)
    func pauseTapped(_ cell: SongTableViewCell)
    func resumeTapped(_ cell: SongTableViewCell)
}

class SongTableViewCell: UITableViewCell, Cell {
    
    //MARK: - Outlet
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var downloadProgress: UIProgressView!
    @IBOutlet weak var percentLabel: UILabel!
    
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    //
    //MARK: - Variable
    //
    weak var delegate: SongTableViewCellDelegate?
    
    //
    //MARK: - Handle Actions
    //
    @IBAction func downloadButton_clicked(_ sender: Any) {
        delegate?.downloadTapped(self)
    }
    
    @IBAction func pauseButtonPressed(_ sender: UIButton) {
        
        print(sender.titleLabel?.text ?? "default")
        
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
    
    //
    //MARK: - Display cell
    //
    func visulizeCell(with track: Track, download: Download?) {
        
        songNameLabel.text = track.name
        artistLabel.text = track.artist
        
        if download?.track.isDownloaded ?? false {
            downloadButton.isHidden = true
            pauseButton.isHidden = true
            cancelButton.isHidden = true
            percentLabel.isHidden = true
            downloadProgress.isHidden = true
            
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
    
    func updateDisplay(progress: Float, totalSize : String, download: Download) {
        
        downloadProgress.progress = progress
        percentLabel.text = String(format: "%.1f%% of %@", progress * 100, totalSize)
        
        if download.isDownloading {
            downloadButton.isHidden = true
            pauseButton.isHidden = false
            cancelButton.isHidden = false
            
            if progress == 1 {
                downloadButton.isHidden = false
                pauseButton.isHidden = true
                cancelButton.isHidden = true
            }
            
        } else {
            
            if pauseButton.titleLabel?.text == "Pause" {
                downloadButton.isHidden = true
                pauseButton.isHidden = false
                cancelButton.isHidden = false
                
            } else {
                downloadButton.isHidden = false
                pauseButton.isHidden = true
                cancelButton.isHidden = true
            }
        }
    }
}
