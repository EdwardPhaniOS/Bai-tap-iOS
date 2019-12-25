//
//  Download.swift
//  iTune
//
//  Created by Tan Vinh Phan on 12/25/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import Foundation

struct Download {
    
    var track: Track
    
    init(track: Track) {
        self.track = track
    }
    
    // Download service sets these values:
    var task: URLSessionDownloadTask?
    var isDownloading = false
    var resumeData: Data?
    
    // Download delegate sets this value:
    var progress: Float = 0
    
}
