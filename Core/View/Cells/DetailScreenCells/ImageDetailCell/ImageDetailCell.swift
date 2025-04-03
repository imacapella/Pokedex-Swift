//
//  ImageDetailCell.swift
//  Pokedex-Swift
//
//  Created by Gürkan Karadaş on 26.03.2025.
//

import UIKit
import Kingfisher
import Foundation

class ImageDetailCell: UITableViewCell {
  @IBOutlet weak var imageDetail: UIImageView!
  
  static let identifier: String = "ImageDetailCell"
  
  static func nib() -> UINib {
    return UINib(nibName: "ImageDetailCell", bundle: nil)
  }
  
  func configure(detail: PokemonDetail) {
    self.imageDetail.kf.setImage(with: URL(string: detail.sprites.frontDefault)!)
    self.imageDetail.frame.size.width = 400
    self.imageDetail.frame.size.height = 400
  }
}
