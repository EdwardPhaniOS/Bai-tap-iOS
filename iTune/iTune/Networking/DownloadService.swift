//
//  DownloadService.swift
//  iTune
//
//  Created by iMac_VTCA on 12/23/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import Foundation

struct DownloadService {
    
    var downloadSession: URLSession!
    
    var activeDownloads: [String: Download] = [:]
    
    mutating func startDownload(with track: Track) {
     
//        guard let url = URL(string: track.previewUrl) else { return }
//
//        let downloadTask = downloadSession.downloadTask(with: url)
//
//        downloadTask.resume()
        
        var download = Download(track: track)
        
        guard let url = URL(string: track.previewUrl) else { return }
        
        download.task = downloadSession.downloadTask(with: url)
        
        download.task?.resume()
        
        download.isDownloading = true
        
        activeDownloads[download.track.previewUrl] = download
    }
    
    
}
