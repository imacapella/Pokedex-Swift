//  DetailScreenViewController.swift
//  Pokedex-Swift
//  Created by Gürkan Karadaş on 24.03.2025.

import Foundation
import UIKit
import Kingfisher

final class DetailScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var pokemonDetailTableView: UITableView!
  
  var pokemonDetails: Any = []
  var pokemonDetail: PokemonDetail?
  var pokemon: Pokemon?
  
  private let imageCellNib = ImageDetailCell.nib()
  private let abilitiesCellNib = AbilitiesCell.nib()
  
  private var cellType = CellTypes.allCases
  private var expandableCellState = ExpandableCellState.allCases
  private var isExpanded: Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    pokemonDetailTableView.dataSource = self //Storyboard kullanarak ver.
    pokemonDetailTableView.delegate = self   //Storyboard kullanarak ver.
    pokemonDetailTableView.register(imageCellNib, forCellReuseIdentifier: ImageDetailCell.identifier)
    pokemonDetailTableView.register(abilitiesCellNib, forCellReuseIdentifier: AbilitiesCell.identifier)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let type = cellType[indexPath.section]
    
    switch type {
    case .imageCell:
      let cell = tableView.dequeueReusableCell(withIdentifier: ImageDetailCell.identifier, for: indexPath) as! ImageDetailCell
      cell.configureImageDetail(detail: pokemonDetail!)
      
      return cell
    case .abilitiesCell:
      let cell = tableView.dequeueReusableCell(withIdentifier: AbilitiesCell.identifier, for: indexPath) as! AbilitiesCell
      //cell.configureAbilities(abilities: pokemonDetail!.abilities, isExpanded: currentState.cellState == .expanded)
      
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let type = cellType[indexPath.section]
    let state = expandableCellState[indexPath.section]
    
    
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 30 }
}


