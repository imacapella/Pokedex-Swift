//  DetailScreenViewController.swift
//  Pokedex-Swift
//  Created by Gürkan Karadaş on 24.03.2025.

import Foundation
import UIKit
import Kingfisher

final class DetailScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var pokemonDetailTableView: UITableView!
  
  var pokemon: Pokemon?
  var pokemonDetail: PokemonDetail?
  
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
    pokemonDetailTableView.estimatedRowHeight = 100
    pokemonDetailTableView.rowHeight = UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return CellTypes.allCases.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let type = cellType[indexPath.section]
    guard let pokemonDetail = pokemonDetail else { return UITableViewCell() }
    
    switch type {
    case .imageCell:
      let cell = tableView.dequeueReusableCell(withIdentifier: ImageDetailCell.identifier, for: indexPath) as! ImageDetailCell
      cell.configureImageDetail(detail: pokemonDetail)
      
      return cell
    case .abilitiesCell:
      let cell = tableView.dequeueReusableCell(withIdentifier: AbilitiesCell.identifier, for: indexPath) as! AbilitiesCell
      cell.configure(pokemonDetail.abilities, isExpanded)
      
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let type = cellType[indexPath.section]
    
    if type == .abilitiesCell {
      isExpanded.toggle()
      tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let type = cellType[indexPath.section]
    
    if type == .abilitiesCell {
      if isExpanded {
        // İç TableView'ın toplam yüksekliği + Diğer UI öğeleri
        let abilityCount = pokemonDetail?.abilities.count ?? 0
        return 70 + CGFloat(abilityCount * 30) // 70 = Başlık yüksekliği, 30 = Her hücre
      } else {
        return 70 // Daraltılmış hal
      }
    } else {
      return UITableView.automaticDimension
    }
  }
}


