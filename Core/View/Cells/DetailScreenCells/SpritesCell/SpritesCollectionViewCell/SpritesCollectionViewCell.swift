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
  @IBOutlet weak var spriteTypeLabel: UILabel!
  
  static func nib() -> UINib {
    return UINib(nibName: identifier, bundle: nil)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func configure(_ detail: PokemonDetail,_ spriteType: SpriteType,_ spriteTypeText: String?) {
    print(DataManager.shared.spriteURLs[detail.name]?[spriteType.rawValue])
    if let url = DataManager.shared.spriteURLs[detail.name]?[spriteType.rawValue] {
      print("url çalıştı")
      spriteImageView.kf.setImage(with: url)
      spriteTypeLabel.text = spriteTypeText?.capitalized ?? "nil"
    }
  }
}



