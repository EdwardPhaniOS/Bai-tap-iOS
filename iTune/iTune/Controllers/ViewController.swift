//
//  ViewController.swift
//  iTune
//
//  Created by iMac_VTCA on 12/20/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

//https://viblo.asia/p/urlsession-chua-bao-gio-de-dang-den-vay-GrLZDQanlk0#_welcome-to-downloadtask-4

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Outlet
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variable
    
    let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    
    var queryService = QueryService()
    var
    downloadService = DownloadService()
    
    var selectedIndexes = [IndexPath]()
    var isDownloading: Bool = false
    
    var tracks = [Track]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var downloadSession: URLSession = {
        
        //config session to download in back ground
        let configuration = URLSessionConfiguration.background(withIdentifier: "download")
        
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.searchTextField.backgroundColor = .white
        searchBar.barTintColor = #colorLiteral(red: 0.5094058514, green: 0.7023435831, blue: 1, alpha: 1)
        searchBar.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        queryService.delegate = self
        
        self.queryService.fetchSong(songName: "Happy_new_year")
        
        downloadService.downloadSession = downloadSession
    }
    
    @IBAction func tappedOnScreen(_ sender: UITapGestureRecognizer) {
        searchBar.resignFirstResponder()
        
        //iOS 12 and before we need this line of code to solve confict between tap gesture and did select row at index path of Table View
        //this mean: tap gesture wil cancel touch event if that position has another view
        sender.cancelsTouchesInView = false
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    
}

//MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath) as! TrackCell
        cell.backgroundColor = .clear
        cell.songNameLabel.text = tracks[indexPath.row].trackName
        cell.artistLabel.text = tracks[indexPath.row].artistName
        
        cell.delegate = self
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - UISearchBarDelegate

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let searchText = searchBar.text!.removingWhitespaces()
        
        self.queryService.fetchSong(songName: searchText)
        
    }
}

private extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}

//MARK: - NetworkManagerDelegate

extension ViewController: NetworkManagerDelegate {
    
    func didUpdateSong(_ networkManager: QueryService, results: [Track]) {
        
        DispatchQueue.main.async {
            self.tracks = results
            self.searchBar.resignFirstResponder()
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}


//MARK: - TrackCellDelegate

extension ViewController: TrackCellDelegate {
    
    func downloadTapped(_ cell: TrackCell) {
        
        if let indexPath = tableView.indexPath(for: cell) {
            let track = tracks[indexPath.row]
            selectedIndexes.append(indexPath)
            downloadService.startDownload(with: track)
        }
    }
    
    func cancelTapped(_ cell: TrackCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let track = tracks[indexPath.row]
            
            if let dowload = downloadService.activeDownloads[track.previewUrl] {
                dowload.task?.cancel()
                downloadService.activeDownloads[track.previewUrl] = nil
            }
        }
    }
}

//MARK: - URLSessionDelegate

extension ViewController: URLSessionDelegate {
    
}

extension ViewController: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
       
        //get original url (previewURL)
        
        guard let sourceURL = downloadTask.originalRequest?.url else { return }
        
        //get last path component to create unique key
        
        let lastPathComponent = sourceURL.lastPathComponent
        
        if let destinationUrl = documentPath?.appendingPathComponent(lastPathComponent) {
            print(destinationUrl)
            
            let fileManager = FileManager.default
            
            //remove item if existed
            try? fileManager.removeItem(at: destinationUrl)
            
            //copy downloaded item from cache to destinationUrl
            do {
                try fileManager.copyItem(at: location, to: destinationUrl)
            } catch let error {
                print(error.localizedDescription)
            }
        }
//
//        let download = downloadService.activeDownloads[sourceURL.absoluteString]
//        downloadService.activeDownloads[sourceURL.absoluteString] = nil
//
//        self.tableView.reloadData()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: .file)
        
        DispatchQueue.main.async {

//            let count = self.selectedIndexes.count
//
//            if count > 0 {
//                if let cell = self.tableView.cellForRow(at: self.selectedIndexes[count - 1]) as? TrackCell {
//                    cell.updateDisplay(progress: progress, totalSize: totalSize)
//                }
//            }
            
            let count = self.selectedIndexes.count
            
            if count > 0 {
                if let cell = self.tableView.cellForRow(at: self.selectedIndexes[count - 1]) as? TrackCell {
                    cell.updateDisplay(progress: progress, totalSize: totalSize)
                }
            }
        }
    }
    
}
