//
//  ChartViewController.swift
//  ExpenseTrackerApp
//
//  Created by Apple on 1/20/25.
//

import UIKit
import DGCharts
import CoreData

class ChartViewController: UIViewController, ChartViewDelegate {

    var pieChart = PieChartView()
    
    var categories = [String]()
    var expenses = [Double]()
    
    var expenses2 = [Expense]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pieChart.delegate = self
               processExpenses()
                configurePieChart()
    }
    override func viewDidLayoutSubviews() {
        pieChart.frame = CGRect(x: 10, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height-100)
        pieChart.center = view.center
        view.addSubview(pieChart)
        
    }
    private func processExpenses() {
         var categoryTotals: [String: Double] = [:]
         
         for expense in expenses2 {
             if let category = expense.category {
                 categoryTotals[category, default: 0.0] += expense.price
             }
         }
         
         self.categories = Array(categoryTotals.keys)
         self.expenses = Array(categoryTotals.values)
     }
    private func configurePieChart() {
            var entries: [PieChartDataEntry] = []
            
            for (index, expenseTotal) in expenses.enumerated() {
                let entry = PieChartDataEntry(value: expenseTotal, label: categories[index])
                entries.append(entry)
            }
            
            let dataSet = PieChartDataSet(entries: entries, label: "")
            
            dataSet.colors = ChartColorTemplates.material() + ChartColorTemplates.vordiplom()
            pieChart.data = PieChartData(dataSet: dataSet)
            
            pieChart.legend.enabled = true
            pieChart.holeRadiusPercent = 0.5
            pieChart.transparentCircleRadiusPercent = 0.55
            pieChart.chartDescription.enabled = false
            pieChart.rotationEnabled = true
            pieChart.animate(xAxisDuration: 1.0, easingOption: .easeOutBounce)
        }
 }

 


