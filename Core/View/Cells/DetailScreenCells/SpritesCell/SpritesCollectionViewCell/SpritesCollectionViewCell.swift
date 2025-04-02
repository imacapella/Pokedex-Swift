//
//  CollectionViewCell.swift
//  Pokedex-Swift
//
//  Created by Gürkan Karadaş on 2.04.2025.
//

import UIKit
import Kingfisher

class SpritesCollectionViewCell: UICollectionViewCell {
  
  static let identifier = "SpritesCollectionViewCell"
  
  @IBOutlet weak var spriteImageView: UIImageView!
  
  static func nib() -> UINib {
    return UINib(nibName: identifier, bundle: nil)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func configure() {
    spriteImageView.kf.setImage(with: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/3.png"))
  }
}




/*spriteImageView.kf.setImage(
  with: url,
  placeholder: UIImage(systemName: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/3.png"),
  options: [
    .transition(.fade(0.3)),
    .cacheOriginalImage
  ]
)*/
