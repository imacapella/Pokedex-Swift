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
  private let spritesCellNib = SpritesCell.nib()
  private let statisticsCellNib = StatisticsCell.nib()
  
  private var cellType = CellTypes.allCases
  private var expandableCellState = ExpandableCellState.allCases
  
  private var isAbilitiesCellExpanded: Bool = false
  private var isSpritesCellExpanded: Bool = false
  private var isStatisticsCellExpanded: Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    pokemonDetailTableView.dataSource = self //Storyboard kullanarak ver.
    pokemonDetailTableView.delegate = self   //Storyboard kullanarak ver.
    pokemonDetailTableView.register(imageCellNib, forCellReuseIdentifier: ImageDetailCell.identifier)
    pokemonDetailTableView.register(abilitiesCellNib, forCellReuseIdentifier: AbilitiesCell.identifier)
    pokemonDetailTableView.register(spritesCellNib, forCellReuseIdentifier: SpritesCell.identifier)
    pokemonDetailTableView.register(statisticsCellNib, forCellReuseIdentifier: StatisticsCell.identifier)
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
      cell.configure(detail: pokemonDetail)
      
      return cell
    case .abilitiesCell:
      let cell = tableView.dequeueReusableCell(withIdentifier: AbilitiesCell.identifier, for: indexPath) as! AbilitiesCell
      cell.configure(with: pokemonDetail.abilities, isAbilitiesCellExpanded)
      
      return cell
    case .spritesCell:
      let cell = tableView.dequeueReusableCell(withIdentifier: SpritesCell.identifier, for: indexPath) as! SpritesCell
      cell.configure(with: pokemonDetail, isSpritesCellExpanded)
      
      return cell
      
    case .statisticsCell:
      let cell = tableView.dequeueReusableCell(withIdentifier: StatisticsCell.identifier, for: indexPath) as! StatisticsCell
      cell.configure(with: pokemonDetail, isStatisticsCellExpanded)
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let type = cellType[indexPath.section]
    
    switch type {
    case .imageCell:
      tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
      
    case .abilitiesCell:
      isAbilitiesCellExpanded.toggle()
      tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
    
    case .spritesCell:
      isSpritesCellExpanded.toggle()
      tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
    case .statisticsCell:
      isStatisticsCellExpanded.toggle()
      tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let type = cellType[indexPath.section]
    
    switch type {
    case .imageCell:
      return 300
      
    case .abilitiesCell:
      if isAbilitiesCellExpanded == true {
        let abilityCount = pokemonDetail?.abilities.count ?? 0
        
        return 100 + CGFloat(abilityCount * 30) // 70 = Başlık yüksekliği, 30 = Her hücre
      } else { return 70 }
      
    case .spritesCell:
      if isSpritesCellExpanded == true { return 200 } else { return 70 }
      
    case .statisticsCell:
      if isStatisticsCellExpanded == true { return 200 } else { return 70 }
    }
  }
}


