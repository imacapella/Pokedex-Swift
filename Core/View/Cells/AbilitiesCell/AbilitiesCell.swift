//
//  AbilitiesCell.swift
//  Pokedex-Swift
//
//  Created by Gürkan Karadaş on 26.03.2025.
//

import UIKit

class AbilitiesCell: UITableViewCell {
  @IBOutlet weak var abilityLabel: UILabel!
  @IBOutlet weak var expandableView: UIStackView!
  static let identifier = "AbilitiesCell"
  
  static func nib() -> UINib {
    return UINib(nibName: identifier, bundle: nil)
  }
  
  /*func configureAbilities(abilities: [PokemonAbilities], isExpanded: Bool) {
    abilityLabel.text = "Abilities (\(abilities.count))"
    expandableView.isHidden = !isExpanded
    
    // Eski içeriği temizle
    expandableView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    
    if isExpanded {
      abilities.forEach { ability in
        let label = UILabel()
        label.text = ability.ability.name.capitalized
        expandableView.addArrangedSubview(label)
      }
    }
  }*/
}
