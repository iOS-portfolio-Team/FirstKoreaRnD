//
//  GameTableViewController.swift
//  TableViewYoutubeRnd
//
//  Created by 정정이 on 2021/03/02.
//

import UIKit
import Kanna
class GameTableViewController: UITableViewController {

    @IBOutlet var listView: UITableView!
    
    var getData:[String] = []
    var chanelName:[String] = []
    var sub:[String] = []
    var views:[String] = []
    var imageUrl:[URL] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listView.delegate = self
        self.listView.dataSource = self
        listView.rowHeight = 150
        

        
        dataCrawlingGame()
        
        var count = 0 // 순위
        
        // 채널명
        for i in 0..<5{
            count += 1
            print("\(count)위  : \(getData[(i*6)+1])")
            chanelName.append(getData[(i*6)+1])
            
        }
        // 구독자수
        for i in 0..<5{
            print("\(getData[(i*6)+3])")
            sub.append(getData[(i*6)+3])
            
        }
        
        // 조회수
        for i in 0..<5{
            print("\(getData[(i*6)+4])")
            views.append(getData[(i*6)+4])
            
        }

      
    
        listView.reloadData()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return chanelName.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! GameTableViewCell

        cell.labelChanelGame.text = "\(chanelName[indexPath.row])"
        cell.labelNumGame.text = "\(indexPath.row+1)"
        cell.labelSubGame.text = "\(sub[indexPath.row])"
        cell.labelViewsGame.text = "\(views[indexPath.row])"
        if cell.labelNumGame.text == "\(1)" {
            let firstColor = #colorLiteral(red: 0.8441851735, green: 0.6620926857, blue: 0.3147920668, alpha: 1)
            cell.labelNumGame.textColor = firstColor
        }
        if cell.labelNumGame.text == "\(2)" {
            let second = #colorLiteral(red: 0.3163542449, green: 0.3409048319, blue: 0.4538033605, alpha: 1)
            cell.labelNumGame.textColor = second
        }
        if cell.labelNumGame.text == "\(3)" {
            let third = #colorLiteral(red: 0.3884379268, green: 0.3042663336, blue: 0.1507078409, alpha: 1)
            cell.labelNumGame.textColor = third
        }
        
        //이미지 URL 크롤링
        DispatchQueue.global().async { [self] in
            let data = try? Data(contentsOf: self.imageUrl[indexPath.row])
            DispatchQueue.main.async {
                cell.imgGame.image = UIImage(data: data!)
                cell.imgGame.layer.cornerRadius = cell.imgGame.frame.height/2
            }
        }

        return cell
    }
    

    
    
    // 게임

    func dataCrawlingGame(){
        let mainURL = "https://kr.noxinfluencer.com/youtube-channel-rank/top-100-kr-gaming-youtuber-sorted-by-subs-weekly"
        guard let main = URL(string: mainURL) else {
            print("Error \(mainURL) doesnt seem to ba a valid URL")
            return
        }
        
        do{
            let htmlDatas = try String(contentsOf: main, encoding: .utf8)
            let doc = try HTML(html: htmlDatas, encoding: .utf8)
           
        
            var count = 1
            

            for title in
                doc.xpath("//*[@id='rank-table-body']/tr/td"){
                count += 1
                getData.append(title.text!.trimmingCharacters(in: .whitespacesAndNewlines))
                
                if count == 30 {
                    break
                }
            }
            count = 0
            for img in
                doc.xpath("//*[@id='rank-table-body']/tr/td/a"){

                if count % 2 == 0{
                    imageUrl.append(URL(string:(img.at_xpath("img")?["src"])!)!)
                    
                }
                count += 1
                if count == 10 {
                    break
                }
            }

            
        }catch let error{
            print("Error : \(error)")
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
