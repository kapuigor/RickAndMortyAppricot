//
//  TableViewCell.swift
//  RickAndMortyAppricot
//
//  Created by Игорь Капустин on 24.04.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    
    // MARK: - Public methods
    func configure(with result: Result?) {
        
        nameLabel.text = result?.name
        speciesLabel.text = result?.species
        genderLabel.text = result?.gender
        
        // Getting image
        DispatchQueue.global().async {
            guard let stringURL = result?.image else { return }
            guard let imageURL = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                self.characterImageView.image = UIImage(data: imageData)
            }
        }
        
        characterImageView.layer.cornerRadius = characterImageView.bounds.height / 6
        
    }
}
