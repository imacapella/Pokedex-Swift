//
//  OtherImagesCell.swift
//  Pokedex-Swift
//
//  Created by Gürkan Karadaş on 31.03.2025.
//

import UIKit
import Kingfisher

class SpritesCell: UITableViewCell {
  
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var iconImage: UIImageView!
  @IBOutlet weak var collectionView: UICollectionView!
  
  static let identifier = "SpritesCell"
  static func nib() -> UINib {
    UINib(nibName: identifier, bundle: nil)
  }
  
  private var spriteURLs: [URL?] = []
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupCollectionView()
  }
  
  private func setupCollectionView() {
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(SpritesCollectionViewCell.nib(), forCellWithReuseIdentifier: SpritesCollectionViewCell.identifier)
  }
  
  func configure(with sprites: Sprites) {
    // Tüm sprite URL'lerini bir array'e ekliyoruz
    spriteURLs = [
      URL(string: sprites.frontDefault),
      URL(string: sprites.backDefault),
      URL(string: sprites.frontShiny),
      URL(string: sprites.backShiny)
    ].compactMap { $0 } // nil olmayan URL'leri filtreliyoruz
    
    collectionView.reloadData()
  }
}

//MARK: - UICollectionView Extensions

extension SpritesCell: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return spriteURLs.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SpritesCollectionViewCell", for: indexPath) as! SpritesCollectionViewCell
    cell.configure()
    return cell
  }
}
