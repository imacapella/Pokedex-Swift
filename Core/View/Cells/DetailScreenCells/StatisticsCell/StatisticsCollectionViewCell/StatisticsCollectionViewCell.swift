//
//  StatisticsCollectionViewCell.swift
//  Pokedex-Swift
//
//  Created by Gürkan Karadaş on 3.04.2025.
//

import UIKit

class StatisticsCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var capsuleView: UIView!
  @IBOutlet weak var halfCapsuleView: UIView!
  @IBOutlet weak var statIconImageView: UIImageView!
  @IBOutlet weak var statTypeLabel: UILabel!
  @IBOutlet weak var statValueLabel: UILabel!
  
  static let identifier = "StatisticsCollectionViewCell"
  
  static func nib() -> UINib {
    return UINib(nibName: identifier, bundle: nil)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    print("CapsuleView frame: \(capsuleView.frame)")
    print("HalfCapsuleView frame: \(halfCapsuleView.frame)")
    print("StatIconImageView frame: \(statIconImageView.frame)")
  }
  
}
