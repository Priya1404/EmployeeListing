//
//  EmployeeTableViewCell.swift
//  EmployeesBioFourmis
//
//  Created by Priya Srivastava on 14/09/21.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {

    //MARK:- IBOutlets
    @IBOutlet weak var employeeImageView: UIImageView!
    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var employeeEmailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateEmployeeDetails(name: String, email: String) {
        employeeNameLabel.text = name
        employeeEmailLabel.text = email
    }
    
    func updateEmployeeImage(image: UIImage) {
        employeeImageView.image = image
    }
}
