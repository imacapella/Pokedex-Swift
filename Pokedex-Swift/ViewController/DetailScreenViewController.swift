//
//  DetailScreenViewController.swift
//  Pokedex-Swift
//
//  Created by Gürkan Karadaş on 24.03.2025.
//

import Foundation
import UIKit
import Kingfisher

class DetailScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var pokemonDetail: PokemonDetail?
    var pokemon: Pokemon?
    @IBOutlet weak var pokemonDetailTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}

