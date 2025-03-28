//  AbilitiesCell.swift
//  Pokedex-Swift
//  Created by Gürkan Karadaş on 26.03.2025.

import UIKit

class AbilitiesCell: UITableViewCell {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var expandableStackView: UIStackView!
  @IBOutlet weak var ability1: UILabel!
  @IBOutlet weak var ability2: UILabel!
  @IBOutlet weak var ability3: UILabel!
  static let identifier = "AbilitiesCell"
  
  static func nib() -> UINib {
    return UINib(nibName: identifier, bundle: nil)
  }
  
  func configure(_ abilities: [PokemonAbilities], _ isExpanded: Bool) {
    ability1.text = abilities.first?.ability.name.capitalized
    ability2.text = abilities.count > 1 ? abilities[1].ability.name.capitalized : ""
    ability3.text = abilities.count > 2 ? abilities[2].ability.name.capitalized : ""
    
    expandableStackView.isHidden = !isExpanded
    self.layoutIfNeeded()
  }
}

