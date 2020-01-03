//
//  MyTableViewController.swift
//  SaveToCache
//
//  Created by Tan Vinh Phan on 12/31/19.
//  Copyright © 2019 PTV. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {
    
    let imageCache = NSCache<AnyObject, AnyObject>()

    let imageURLPaths = [
        "https://images.pexels.com/photos/1236701/pexels-photo-1236701.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260", "https://cdn.pixabay.com/photo/2019/12/23/15/07/freiburg-4714770__480.jpg", "https://cdn.pixabay.com/photo/2019/12/28/14/00/chrome-hill-4724723__480.jpg",
        "https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__480.jpg", "https://cdn.pixabay.com/photo/2019/12/23/15/07/freiburg-4714770__480.jpg", "https://cdn.pixabay.com/photo/2019/12/28/14/00/chrome-hill-4724723__480.jpg",
        "https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__480.jpg", "https://cdn.pixabay.com/photo/2019/12/23/15/07/freiburg-4714770__480.jpg", "https://cdn.pixabay.com/photo/2019/12/28/14/00/chrome-hill-4724723__480.jpg",
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 200
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return imageURLPaths.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyCell
        
        if let imageURL = URL(string: imageURLPaths[indexPath.row]) {
            
            if let image = self.imageCache.object(forKey: imageURL as AnyObject) {
                DispatchQueue.main.async {
                    cell.cellImageView.image = image as? UIImage
                }
                
            } else {
                downloadImage(imageURL: imageURL) { (image) in
                    DispatchQueue.main.async {
                        cell.cellImageView.image = image
                    }

                    //Save Image to imageCache
                    if let safeImage = image {
                        self.imageCache.setObject(safeImage, forKey: imageURL as AnyObject)
                    }
                }
            }
        }
        
        return cell
    }
    
    func downloadImage(imageURL: URL, completion: @escaping (UIImage?) -> Void) {
        
        let session = URLSession(configuration: .default)
        
        let downloadImageTask = session.dataTask(with: imageURL) { (data, response, error) in
            
            if let e = error {
                print("Error downloading images: \(e)")
            } else {
                
                if let safeResponse = response as? HTTPURLResponse {
                    
                    guard let imageData = data else {
                        print("Couldn't get image data")
                        return }
                    
                    let image = UIImage(data: imageData)
                    completion(image)
                    
                } else {
                    print("Couldn't get response code")
                }
            }
        }
        
        downloadImageTask.resume()
    }
   
}
