//  DetailScreenViewController.swift
//  Pokedex-Swift
//  Created by Gürkan Karadaş on 24.03.2025.

import Foundation
import UIKit
import Kingfisher

enum PokemonDetailTableViewCellType: CaseIterable {
  case imageCell
  case abilitiesCell
}

final class DetailScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  @IBOutlet weak var pokemonDetailTableView: UITableView!
  
  var pokemonDetails: Any = []
  var pokemonDetail: PokemonDetail?
  var pokemon: Pokemon?
  
  var types: [PokemonDetailTableViewCellType] = PokemonDetailTableViewCellType.allCases
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    pokemonDetailTableView.dataSource = self
    pokemonDetailTableView.delegate = self
    pokemonDetailTableView.register(ImageDetailCell.nib(), forCellReuseIdentifier: ImageDetailCell.identifier)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return types.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      let imageCell = tableView.dequeueReusableCell(withIdentifier: ImageDetailCell.identifier, for: indexPath) as! ImageDetailCell
      
      if let detail = pokemonDetail {
        imageCell.configureImageDetail(detail: detail)
      }
      
      return imageCell
    } else {
      
      return UITableViewCell()
    }
  }
}
