//
//  FoodViewController.swift
//  foodStoreRnD
//
//  Created by TJ on 2021/03/04.
//

import UIKit

class FoodViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FoodJsonModelProtocol  {
    
    
    @IBOutlet var foodListTableView: UITableView!
    var feedItem: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.foodListTableView.delegate = self
        self.foodListTableView.dataSource = self
        
        
        let foodJsonModel = FoodJsonModel()
        foodJsonModel.delegate = self
        foodJsonModel.downloadItems()
        
        
        
        
        // 그림 크기
        foodListTableView.rowHeight = 202 // Cell 높이. <----------- 중요
    }
    
    func itemDownloaded(items: NSArray) {
        // items == location
        feedItem = items
        self.foodListTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodCell", for: indexPath) as! FoodTableViewCell

        // Configure the cell...
        // 셀 구성 정해주기
        let item: FoodDBModel = feedItem[indexPath.row] as! FoodDBModel
       
        cell.lblStoreName?.text = "\(item.storeName!)"
        cell.lblStoreScore?.text = "\(item.storeScore!)"
        cell.lblStoreCategory?.text = "\(item.storeCategory!)"
        cell.lblPriceRange?.text = "\(item.priceRange!)"
        cell.lblStoreAddress?.text = "\(item.storeAddress!)"
    
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
