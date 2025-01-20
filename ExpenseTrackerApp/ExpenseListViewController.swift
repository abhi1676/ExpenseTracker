//
//  ExpenseListViewController.swift
//  ExpenseTrackerApp
//
//  Created by Apple on 1/20/25.
//

import UIKit
import CoreData

class ExpenseListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,reloadTableview {
 
    
    
    
    
    
    
    @IBOutlet var tableview: UITableView!
    
    @IBOutlet var modeSwicth: UISwitch!
    
    
    @IBOutlet var totalCost: UILabel!
    var expenses: [Expense] = []
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modeSwicth.isOn = true
        setUpTableview()
        updateTotalCost()
        fetchExpenses()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchExpenses()
        updateTotalCost()
    }
    
    func setUpTableview(){
        
        tableview.delegate = self
        tableview.dataSource = self
        let nib = UINib(nibName: "ExpensesTableViewCell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "ExpensesTableViewCell")
        tableview.layer.cornerRadius = 20
        
    }
    
    
    func fetchExpenses() {
        let request: NSFetchRequest<Expense> = Expense.fetchRequest()
        do {
            expenses = try context.fetch(request)
            tableview.reloadData()
            updateTotalCost() // Update the total cost after fetching expenses
            
        } catch {
            print("Error fetching: \(error)")
        }
    }
    
    func updateTotalCost() {
        let total = expenses.reduce(0) { $0 + $1.price }
        totalCost.text = "Total Expenses: $\(total)"
    }
    func reloadData() {
        self.fetchExpenses()
    }
    
    
    @IBAction func navigateToChart(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "ChartViewController") as? ChartViewController else {return}
        vc.expenses2 = self.expenses
        self.navigationController?.pushViewController(vc, animated: true)
                
        
    }
    
    
    @IBAction func addExpense(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "ExpenseViewController") as? ExpenseViewController {
            vc.modalTransitionStyle = .coverVertical
            vc.delegate = self
            present(vc, animated: true)
        }
    }
    
    @IBAction func changeMode(_ sender: Any) {
        if modeSwicth.isOn == true
        {
            let window = UIApplication.shared.windows[0]
            window.overrideUserInterfaceStyle = .light
        }
        else {
            
            let window = UIApplication.shared.windows[0]
            window.overrideUserInterfaceStyle = .dark
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpensesTableViewCell", for: indexPath) as! ExpensesTableViewCell
        
        let expense = expenses[indexPath.row]
        cell.expenseTitle.text = expense.title
        cell.expenseCategory.text = expense.category
        cell.expensePrice.text = String(format: "$%.2f", expense.price)
        
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Delete Action
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            let expenseTodelete = self.expenses[indexPath.row]
            
            self.context.delete(expenseTodelete)
            do {
                try self.context.save()
                self.fetchExpenses()
            } catch {
                print("Error deleting task:", error.localizedDescription)
            }
            
            completionHandler(true)
        }
        
        
        
        
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
        
    }
    
    
}
    
    

