//
//  ViewController.swift
//  SwiftDemo
//
//  Created by apple on 2021/5/16.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let apiServices: ApiServices = ApiServices();
    let tableview: UITableView = UITableView();
    var dataSource: [YearMobileDataUsage]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        reuestData()
    }
    
    func initUI() {
        self.view.backgroundColor = UIColor.white;
        self.tableview.frame = self.view.bounds
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.register(MobileDataUsageCell.self, forCellReuseIdentifier: "MobileDataUsageCell")
        self.view.addSubview(self.tableview);
    }
    
    func reuestData() {
        apiServices.fetchMobileDataUsage { (resultArray: [QuarterlyMobileDataUsage]) in
            let yearData: [YearMobileDataUsage] = YearMobileDataUsage.transQuarterlyDataToYearData(sourceData: resultArray)
            self.dataSource = yearData
            self.tableview.reloadData()
        } failure: { (error: NetworkError) in
            let alertView = UIAlertController.init(title: "alert", message: error.message, preferredStyle: .alert)
            let cancleAlert = UIAlertAction.init(title: "ok", style: .cancel) { (UIAlertAction) in
                print("clicked")
            }
            alertView.addAction(cancleAlert)
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dataSource = dataSource {
            return dataSource.count;
        } else {
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MobileDataUsageCell = tableview.dequeueReusableCell(withIdentifier: "MobileDataUsageCell", for: indexPath) as! MobileDataUsageCell
        if let useage = self.dataSource?[indexPath.row] {
            cell.timeLabel?.text = useage.year
            cell.dataLabel?.text = useage.volumeOfMobileData
            if useage.isDecrease {
                cell.contentView.backgroundColor = UIColor.gray
            } else {
                cell.contentView.backgroundColor = UIColor.white
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    
}

