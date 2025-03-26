//
//  AbilitiesCell.swift
//  Pokedex-Swift
//
//  Created by Gürkan Karadaş on 26.03.2025.
//

import UIKit

class AbilitiesCell: UITableViewCell {
  @IBOutlet weak var abilityLabel: UILabel!
  
  static let identifier = "AbilitiesCell"
  
  static func nib() -> UINib {
    return UINib(nibName: identifier, bundle: nil)
  }
}
