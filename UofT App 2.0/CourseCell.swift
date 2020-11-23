//
//  CourseCell.swift
//  UofT App 2.0
//
//  Created by Danny Vo on 2020-11-23.
//

import UIKit

class CourseCell: UITableViewCell {

    var courseIDLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(courseIDLabel)
        
        configureCourseID()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCourseID() {
        courseIDLabel.numberOfLines             = 0
        courseIDLabel.adjustsFontSizeToFitWidth = true
    }
    
//    func setTitleLabelConstraints() {
//        courseIDLabel.translatesAutoresizingMaskIntoConstraints = false
//        courseIDLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        courseIDLabel.leadingAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutXAxisAnchor>#>)
//    }
    
}
