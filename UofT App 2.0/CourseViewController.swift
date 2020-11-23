//
//  CourseViewController.swift
//  UofT App 2.0
//
//  Created by Danny Vo on 2020-11-23.
//

import Foundation
import UIKit

class CourseViewController: UIViewController {
    let tableView = UITableView()
    var courses = [CourseResult]()
    var total = [[CourseResult]]()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search Course ID"
        searchController.obscuresBackgroundDuringPresentation   = false
        
        navigationItem.searchController = searchController
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
        
        tableView.register(CourseCell.self, forCellReuseIdentifier: "cell")
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
            var result: CourseResponse?
            do {
                result = try JSONDecoder().decode(CourseResponse.self, from: data)
            } catch {
                debugPrint(error)
            }
            
            guard let json = result else { return }
            self.courses = json.response
            
            var toronto = [CourseResult]()
            var mississauga = [CourseResult]()
            var scarborough = [CourseResult]()
            
            for course in self.courses {
                if course.campus == "St. George" {
                    toronto.append(course)
                } else if course.campus == "Mississauga" {
                    mississauga.append(course)
                } else if course.campus == "Scarborough" {
                    scarborough.append(course)
                }
            }
            
            self.total.removeAll()
            self.total.append(toronto)
            self.total.append(mississauga)
            self.total.append(scarborough)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        task.resume()
    }
}

extension CourseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return total[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return total.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = total[indexPath.section][indexPath.row].code + " | " + total[indexPath.section][indexPath.row].term
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Toronto"
        }
        if section == 1 {
            return "Mississauga"
        }
        if section == 2 {
            return "Scarborough"
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let courseDetailViewController = CourseDetailViewController()
        courseDetailViewController.course = total[indexPath.section][indexPath.row]
        navigationController?.pushViewController(courseDetailViewController, animated: true)
    }
}

extension CourseViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar

        if searchBar.text!.count > 1 {
            let url = "https://nikel.ml/api/courses?id=" + searchBar.text! //+ "&limit=1"
            getData(from: url)
        }
    }
}
