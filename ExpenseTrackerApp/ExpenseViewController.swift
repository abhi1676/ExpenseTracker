//
//  ExpenseViewController.swift
//  ExpenseTrackerApp
//
//  Created by Apple on 1/20/25.
//

import UIKit

protocol reloadTableview{
    func reloadData()
}

class ExpenseViewController: UIViewController {
    
    
    @IBOutlet var titleTextfield: UITextField!
    
    @IBOutlet var categoryTextfield: UITextField!
    
    @IBOutlet var amountTextfield: UITextField!
    
    var delegate : reloadTableview?
    
    @IBOutlet var datePicker: UIDatePicker!
    
    let datepkr = UIDatePicker()
    
    var expenses : [Expense]?
    var context = (UIApplication.shared.delegate as!
                   AppDelegate).persistentContainer.viewContext
                   
    override func viewDidLoad() {
        super.viewDidLoad()

      
        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveExpense(_ sender: Any) {
        guard let title = titleTextfield.text, !title.isEmpty,
                     let category = categoryTextfield.text, !category.isEmpty,
                     let amountText = amountTextfield.text, let amount = Double(amountText) else {
                   // Show an alert if validation fails
                   showAlert(message: "Please fill in all fields correctly.")
                   return
               }

               // Create a new Expense object
               let newExpense = Expense(context: context)
               newExpense.title = title
               newExpense.category = category
                newExpense.price = amount
               newExpense.date = datePicker.date

               // Save to Core Data
               do {
                   try context.save()
                   showAlert2(message: "Expense saved successfully!"){
                       self.dismiss(animated: true)
                       self.delegate?.reloadData()

                   }
                   clearFields() 
               } catch {
                   print("Error saving expense: \(error)")
                   showAlert(message: "Failed to save expense.")
               }
    }
    
    private func showAlert(message: String) {
            let alert = UIAlertController(title: "Expense Tracker", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }

    private func showAlert2(message: String, completion: (() -> Void)? = nil) {
          let alert = UIAlertController(title: "Expense Tracker", message: message, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
              completion?()
          }))
          present(alert, animated: true, completion: nil)
      }
    
        // Helper function to clear text fields after saving
        private func clearFields() {
            titleTextfield.text = ""
            categoryTextfield.text = ""
            amountTextfield.text = ""
            datePicker.date = Date()
        }
    
    
    @IBAction func closePopUp(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}
