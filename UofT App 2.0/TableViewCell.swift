//
//  CourseCell.swift
//  UofT App 2.0
//
//  Created by Danny Vo on 2020-11-23.
//

import UIKit

class TableViewCell: UITableViewCell {

    var cellLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(cellLabel)
        
        configureCourseID()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCourseID() {
        cellLabel.numberOfLines             = 0
        cellLabel.adjustsFontSizeToFitWidth = true
    }
}
