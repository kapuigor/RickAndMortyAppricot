//
//  CharacterDetialsViewController.swift
//  RickAndMortyAppricot
//
//  Created by Игорь Капустин on 24.04.2022.
//

import UIKit

class CharacterDetailsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    
    // MARK: - Public properties
    var result: Result?
    var characterURL: String!
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.fetchCharacter(from: characterURL) { result in
            self.result = result
            self.title = result.name
            self.descriptionLabel.text = result.description
            
            DispatchQueue.global().async {
                guard let stringURL = self.result?.image else { return }
                guard let imageURL = URL(string: stringURL) else { return }
                guard let imageData = try? Data(contentsOf: imageURL) else { return }
                DispatchQueue.main.async {
                    self.characterImageView.image = UIImage(data: imageData)
                }
            }
            
            self.characterImageView.layer.cornerRadius = self.characterImageView.bounds.height / 6
        }
    }
}
