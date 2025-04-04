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
    layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 24)
    layout.minimumLineSpacing = 8
    layout.minimumInteritemSpacing = 0
    layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
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
