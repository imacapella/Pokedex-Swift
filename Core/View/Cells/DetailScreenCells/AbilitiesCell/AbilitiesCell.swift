//  AbilitiesCell.swift
//  Pokedex-Swift
//  Created by Gürkan Karadaş on 26.03.2025.

import UIKit

class AbilitiesCell: UITableViewCell {
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var abilitiesTableView: UITableView!
  @IBOutlet weak var arrowImageView: UIImageView!
  
  static let identifier = "AbilitiesCell"
  private var image: UIImage?
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
  
  private func setupTableView() {
    abilitiesTableView.delegate = self
    abilitiesTableView.dataSource = self
    abilitiesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "AbilityCell")
  }
  
  func configure(_ abilities: [PokemonAbilities], _ isExpanded: Bool) {
    self.abilities = abilities
    abilitiesTableView.reloadData()
    
    if isExpanded {
      image = UIImage(systemName: "arrow.up")
      let totalHeight = CGFloat(abilities.count * 30) // Her hücre 30 birim yüksekliğinde
      abilitiesTableView.heightAnchor.constraint(equalToConstant: totalHeight).isActive = true
      arrowImageView.image = image
    } else {
      image = UIImage(systemName: "arrow.down")
      arrowImageView.image = image
    }
    
    self.layoutIfNeeded()
  }
}

//MARK: - TableView Extensions (numberOfRowsInSection, cellForRowAt, heightForRowAt)
extension AbilitiesCell: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return abilities.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "AbilityCell", for: indexPath)
    cell.textLabel?.text = abilities[indexPath.row].ability.name.localizedCapitalized
    cell.selectionStyle = .none
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 30
  }
}


