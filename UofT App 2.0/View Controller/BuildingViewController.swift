//
//  BuildingViewController.swift
//  UofT App 2.0
//
//  Created by Danny Vo on 2020-11-24.
//

import Foundation
import UIKit

class BuildingViewController: UIViewController {
    
    let tableView = UITableView()
    var buildings = [BuildingResult]()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search Building ID"
        searchController.obscuresBackgroundDuringPresentation   = false
        
        navigationItem.searchController                         = searchController
        navigationItem.hidesSearchBarWhenScrolling              = false
        
        setupTableView()
    }
    
    func setupTableView() {
        // Adding tableview to this View Controller.
        view.addSubview(tableView)
        
        // Set Delegates
        setTableViewDelegates()
        
        tableView.translatesAutoresizingMaskIntoConstraints                     = false
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive        = true
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive      = true
        
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive  = true
        
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive    = true
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "buildingCell")
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getData(from url: String) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("Something went wrong.")
                return
            }
            var result: BuildingResponse?
            do {
                result = try JSONDecoder().decode(BuildingResponse.self, from: data)
            } catch {
                debugPrint(error)
            }
            
            guard let json = result else { return }
            self.buildings = json.response
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        task.resume()
    }
}

extension BuildingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buildings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "buildingCell", for: indexPath)
        cell.textLabel?.text = buildings[indexPath.row].code + " | " + buildings[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let buildingDetailController = BuildingDetailController()
        buildingDetailController.building = buildings[indexPath.row]
        navigationController?.pushViewController(buildingDetailController, animated: true)
    }
}

extension BuildingViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        if searchBar.text!.count > 0 {
            let url = "https://nikel.ml/api/buildings?code==" + searchBar.text!.uppercased()
            getData(from: url)
        }
    }
}
