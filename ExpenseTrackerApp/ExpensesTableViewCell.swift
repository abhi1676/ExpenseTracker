//
//  ExpensesTableViewCell.swift
//  ExpenseTrackerApp
//
//  Created by Apple on 1/20/25.
//

import UIKit

class ExpensesTableViewCell: UITableViewCell {
    
    
    @IBOutlet var expenseTitle: UILabel!
    
    @IBOutlet var expenseCategory: UILabel!
    
    @IBOutlet var expensePrice: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.gray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
