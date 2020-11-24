//
//  BuildingDetailController.swift
//  UofT App 2.0
//
//  Created by Danny Vo on 2020-11-24.
//

import Foundation
import UIKit

class BuildingDetailController: UIViewController, UITableViewDelegate {
    let tableView = UITableView()
    
    var building: BuildingResult!
    var detail = [String]() // array containing all the information for buildings
    
    override func loadView() {
        super.loadView()
        setupTableView()
        
        title = building.name
        navigationController?.navigationBar.prefersLargeTitles = true
        
        detail.append("Name: " + building.name)
        detail.append("Code: " + building.code)
        detail.append("Short Name: " + building.short_name)
        detail.append("Street: " + building.address.street)
        detail.append("Campus: " + building.address.city)
    }
    
    func setupTableView() {
        
        // Adding tableview to this View Controller
        view.addSubview(tableView)
        
        // Set Delegates
        setTableViewDelegates()
        
        tableView.translatesAutoresizingMaskIntoConstraints                     = false
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive        = true
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive      = true
        
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive  = true
        
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive    = true
        
        tableView.register(CourseCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
    }
}

extension BuildingDetailController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detail.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "buildingCell", for: indexPath)
        
        cell.textLabel?.numberOfLines = 0
        
        cell.textLabel?.text = detail[indexPath.row]
        return cell
    }
}

