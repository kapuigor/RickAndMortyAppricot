//
//  NetworkManager.swift
//  RickAndMortyAppricot
//
//  Created by Игорь Капустин on 24.04.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    // Fetching data
    func fetchData(from url: String?, with complition: @escaping (RickAndMorty) -> Void) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let rickAndMorty = try JSONDecoder().decode(RickAndMorty.self, from: data)
                DispatchQueue.main.async {
                    complition(rickAndMorty)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    // Fetching character
    func fetchCharacter(from url: String, completion: @escaping(Result) -> Void) {
        guard let url = URL(string: url) else {
            return
        }

        URLSession.shared.dataTask(with: url) {
            (data, _, error) in
            guard let data = data else {
                print(error?.localizedDescription ?? "No description")
                return
            }

            do {
                let result = try
                JSONDecoder().decode(Result.self, from: data)
                DispatchQueue.main.async {
                    completion(result)
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
