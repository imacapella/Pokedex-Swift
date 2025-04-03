//  OtherImagesCell.swift
//  Pokedex-Swift
//  Created by Gürkan Karadaş on 31.03.2025.

import UIKit
import Kingfisher

class SpritesCell: UITableViewCell {

  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var expandIcon: UIImageView!
  @IBOutlet weak var collectionView: UICollectionView!
  
  let spriteType = SpriteType.allCases
  let spriteTypeDictionary: [SpriteType: String] = [
    .frontDefault : "Front Default",
    .frontShiny: "Front Shiny",
    .frontFemale: "Front Female",
    .backDefault: "Back Default",
    .backShiny: "Back Shiny",
    .backFemale: "Back Female",
    .backShinyFemale: "Back Shiny Female",
  ]

  static let identifier = "SpritesCell"
  static func nib() -> UINib {
    UINib(nibName: identifier, bundle: nil)
  }
  
  // Seçilen PokemonDetail bilgisini saklayacak property
  private var detail: PokemonDetail?

  override func awakeFromNib() {
    super.awakeFromNib()
    setupCollectionView()
  }
  
  private func setupCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(SpritesCollectionViewCell.nib(), forCellWithReuseIdentifier: SpritesCollectionViewCell.identifier)
  }
  
  func configure(with detail: PokemonDetail,_ isExpanded: Bool) {
    self.detail = detail
    collectionView.reloadData()
    expandIcon.image = isExpanded ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
  }
}

//MARK: - UICollectionView Extensions
extension SpritesCell: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return SpriteType.allCases.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpritesCollectionViewCell.identifier, for: indexPath) as! SpritesCollectionViewCell
    if let detail = self.detail {
      let spriteType = SpriteType.allCases[indexPath.item]
      cell.configure(detail, spriteType, spriteTypeDictionary[spriteType])
    } else {
      print("detail is nil in SpritesCell")
    }
    return cell
  }
}
