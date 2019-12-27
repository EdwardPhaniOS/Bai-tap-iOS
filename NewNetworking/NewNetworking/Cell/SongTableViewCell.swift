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
    func resumeTapped(_ cell: SongTableViewCell)
}

class SongTableViewCell: UITableViewCell, Cell {
    
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var downloadProgress: UIProgressView!
    @IBOutlet weak var percentLabel: UILabel!
    
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    weak var delegate: SongTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func downloadButton_clicked(_ sender: Any) {
        delegate?.downloadTapped(self)
    }
    
    func visulizeCell(with track: Track) {
        songNameLabel.text = track.name
        artistLabel.text = track.artist
        
        pauseButton.setTitle("Pause", for: .normal)
    }
    
    func updateDisplay(progress: Float, totalSize : String, download: Download) {
      downloadProgress.progress = progress
      percentLabel.text = String(format: "%.1f%% of %@", progress * 100, totalSize)
        
        if download.isDownloading {
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
