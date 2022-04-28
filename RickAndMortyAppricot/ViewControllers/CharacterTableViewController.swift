//
//  CharacterTableViewController.swift
//  RickAndMortyAppricot
//
//  Created by Игорь Капустин on 24.04.2022.
//

import UIKit

class CharacterTableViewController: UITableViewController {

    // MARK: - Private properties
    private var rickAndMorty: RickAndMorty?
    
    // MARK: - UIViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 100
        
        setupNavigationBar()
        fetchData(from: URLS.rickAndMortyAPI.rawValue)

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rickAndMorty?.results.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell

        let result = rickAndMorty?.results[indexPath.row]
        cell.configure(with: result)

        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let character = rickAndMorty?.results[indexPath.row]
        let detailVC = segue.destination as! CharacterDetailsViewController
        detailVC.characterURL = character?.url
        }
    
    @IBAction func updateData(_ sender: UIBarButtonItem) {
        sender.tag == 1 ? fetchData(from: rickAndMorty?.info.next) : fetchData(from: rickAndMorty?.info.prev)
    }
    
    // MARK: - Private methods
    
    // Setup navigation bar
    private func setupNavigationBar() {
        
        title = "Rick & Morty"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // Fetching data
    private func fetchData(from url: String?) {
        NetworkManager.shared.fetchData(from: url) {
            rickAndMorty in
            self.rickAndMorty = rickAndMorty
            self.tableView.reloadData()
        }
    }
}
