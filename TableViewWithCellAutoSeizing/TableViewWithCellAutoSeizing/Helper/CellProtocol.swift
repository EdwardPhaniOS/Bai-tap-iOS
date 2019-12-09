//
//  CellProtocol.swift
//  TableViewWithCellAutoSeizing
//
//  Created by iMac_VTCA on 12/9/19.
//  Copyright © 2019 iMac_VTCA. All rights reserved.
//

import UIKit

protocol CellProtocol {
    static var identity: String { get }
}

extension CellProtocol {
    static var identity: String {
        return "\(self)"
    }
}

extension CellProtocol where Self : UITableViewCell {
    
    static func createCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> Self {
        let cell = tableView
            .dequeueReusableCell(withIdentifier: self.identity, for: indexPath) as! Self
            
        return cell
    }
}

extension CellProtocol where Self : UICollectionViewCell {
    
    static func createCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> Self {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.identity, for: indexPath) as! Self
            
        return cell
    }
}




