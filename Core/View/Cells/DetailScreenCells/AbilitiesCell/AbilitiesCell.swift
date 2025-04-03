//  AbilitiesCell.swift
//  Pokedex-Swift
//  Created by Gürkan Karadaş on 26.03.2025.

import UIKit

class AbilitiesCell: UITableViewCell {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var expandableStackView: UIStackView!
  @IBOutlet weak var abilitiesTableView: UITableView!
  @IBOutlet weak var expandIcon: UIImageView!
  
  static let identifier = "AbilitiesCell"
  private var abilities: [PokemonAbilities] = []
  
  static func nib() -> UINib {
    return UINib(nibName: identifier, bundle: nil)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupTableView()
  }
  
  // MARK: - PrepareForReuse
  override func prepareForReuse() {
    super.prepareForReuse()
    abilities.removeAll()
  }
  
  override func layoutSubviews() {
      super.layoutSubviews()
      print("TableView frame: \(abilitiesTableView.frame)")
  }
  
  private func setupTableView() {
    abilitiesTableView.delegate = self
    abilitiesTableView.dataSource = self
    abilitiesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "AbilityCell")
  }
  
  func configure(with abilities: [PokemonAbilities], _ isExpanded: Bool) {
    self.abilities = abilities
    expandableStackView.isHidden = !isExpanded
    abilitiesTableView.reloadData()
    abilitiesTableView.layoutIfNeeded()
    expandIcon.image = isExpanded ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
  }
}

extension AbilitiesCell: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return abilities.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "AbilityCell", for: indexPath)
    cell.textLabel?.text = abilities[indexPath.row].ability.name.capitalized
    cell.selectionStyle = .none
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 30
  }
}


