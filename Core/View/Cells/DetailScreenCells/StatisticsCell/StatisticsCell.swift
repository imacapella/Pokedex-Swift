//
//  StatisticsCell.swift
//  Pokedex-Swift
//
//  Created by Gürkan Karadaş on 3.04.2025.
//

import UIKit

class StatisticsCell: UITableViewCell {
  @IBOutlet weak var statisticsCollectionView: UICollectionView!
  @IBOutlet weak var expandIcon: UIImageView!
  
  static let identifier = "StatisticsCell"
  
  static func nib() -> UINib {
    return UINib(nibName: identifier, bundle: nil)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.setupCollectionView()
  }
  
  private func setupCollectionView() {
    statisticsCollectionView.delegate = self
    statisticsCollectionView.dataSource = self
    statisticsCollectionView.register(StatisticsCollectionViewCell.nib(), forCellWithReuseIdentifier: StatisticsCollectionViewCell.identifier)
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 300, height: 100) // XIB'deki boyutlarla uyumlu olmalı
    layout.minimumLineSpacing = 10
    layout.minimumInteritemSpacing = 10
    statisticsCollectionView.collectionViewLayout = layout
  }
  
  func configure(with stats: PokemonDetail,_ isExpanded: Bool) {
    expandIcon.image = isExpanded ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
  }
}

extension StatisticsCell: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StatisticsCollectionViewCell", for: indexPath) as! StatisticsCollectionViewCell
    return cell
  }
}
