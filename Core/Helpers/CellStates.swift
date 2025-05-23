//  CellStates.swift
//  Pokedex-Swift
//  Created by Gürkan Karadaş on 27.03.2025.

import Foundation

//MARK: - Helpers
enum CellTypes: CaseIterable {
  case imageCell
  case abilitiesCell
  case spritesCell
  case statisticsCell
}

enum ExpandableCellState: CaseIterable {
  case normal
  case expanded
}
