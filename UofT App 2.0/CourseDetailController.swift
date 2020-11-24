//
//  CourseDetailController.swift
//  UofT App 2.0
//
//  Created by Danny Vo on 2020-11-23.
//

import Foundation
import UIKit

class CourseDetailViewController: UIViewController {
    let tableView = UITableView()
    
    var course: CourseResult!
    var detail = [String]() // array containing all the information for courses
    var total = [[String]]() // array containing both the DETAIL and the DATE/ Time
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        setupTableView()
        
        title = course.code
        
        detail.append("Name: " + course.name)
        detail.append("Description: " + course.description)
        detail.append("Division: " + course.division)
        
        if (course.prerequisites != nil) {
            detail.append("Prerequisite: " + course.prerequisites!)
        } else {
            detail.append("Prerequisite: None")
        }
        
        if (course.corequisites != nil) {
            detail.append("Corequisite: " + course.corequisites!)
        } else {
            detail.append("Corequisite: None")
        }
        
        if (course.exclusions != nil){
            detail.append("Exclusions: " + course.exclusions!)
        } else {
            detail.append("Exclusions: None")
        }
        
        if (course.recommended_preparation != nil){
            detail.append("Recommended Prep: " + course.recommended_preparation!)
        } else {
            detail.append("Recommended Prep: None")
        }
        
        detail.append("Level: " + course.level!)
        detail.append("Campus: " + course.campus)
        detail.append("Term: " + course.term)
        total.append(detail)
        
        var index = 0
        while index < course.meeting_sections.count {
            var courseDate = [String]()
            courseDate.append("Section: " + course.meeting_sections[index].code.uppercased())

            if !(course.meeting_sections[index].times.isEmpty) {
                if (course.meeting_sections[index].times[0].day != nil) {
                    courseDate.append("Day: " + course.meeting_sections[index].times[0].day!.capitalized)
                } else {
                    courseDate.append("Day: Not available")
                }
                
                var start = course.meeting_sections[index].times[0].start! / 3600
                if start == 0 {
                    courseDate.append("Start: Not Available")
                } else {
                    if start >= 12 {
                        if start > 12 {
                            start -= 12
                        }
                        courseDate.append("Start: " + String(start) + ":00 PM")
                    } else {
                        courseDate.append("Start: " + String(start) + ":00 AM")
                    }
                    
                }
                
                var end = course.meeting_sections[index].times[0].end! / 3600
                if end == 0 {
                    courseDate.append("End: Not Available")
                } else {
                    if end >= 12 {
                        if end > 12 {
                            end -= 12
                        }
                        courseDate.append("End: " + String(end) + ":00 PM")
                    } else {
                        courseDate.append("End: " + String(end) + ":00 AM")
                    }
                }
                
                let duration = course.meeting_sections[index].times[0].duration! / 3600
                if duration == 0 {
                    courseDate.append("Duration: Not Available")
                } else {
                    courseDate.append("Duration: " + String(duration) + ":00 hour")
                }
                
                if (course.meeting_sections[index].times[0].location != nil){
                    courseDate.append("Location: " + course.meeting_sections[index].times[0].location!)
                } else {
                    courseDate.append("Location: Not available")
                }
            }
            
            if (course.meeting_sections[index].size != 0){
                courseDate.append("Class size: " + String(course.meeting_sections[index].size!))
            } else {
                courseDate.append("Class size: Not available")
            }
            
            courseDate.append("Delivery Type: " + course.meeting_sections[index].delivery)
            
            index += 1
            total.append(courseDate)
        }
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

extension CourseDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Class Description"
        } else {
            return "Lecture/ Tutorial Information \(section)"
        }
    }
}

extension CourseDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return total[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return total.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // allows the text to wrap around to the next line rather than trailing dots
        cell.textLabel?.numberOfLines = 0

        
        // have a total array, with subarrays to separate for sections
        cell.textLabel?.text = total[indexPath.section][indexPath.row]
        return cell
    }
}
