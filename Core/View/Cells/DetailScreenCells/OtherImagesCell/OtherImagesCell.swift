//
//  OtherImagesCell.swift
//  Pokedex-Swift
//
//  Created by Gürkan Karadaş on 31.03.2025.
//

import UIKit

class OtherImagesCell: UITableViewCell {
  
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var iconImage: UIImageView!
  @IBOutlet weak var collectionView: UICollectionView!
  
  static let identifier = "OtherImagesCell"
  static func nib() -> UINib {
    UINib(nibName: identifier, bundle: nil)
  }
  
  
  
}
