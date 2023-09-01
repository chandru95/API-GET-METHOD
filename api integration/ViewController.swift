//
//  ViewController.swift
//  api integration
//
//  Created by Admin on 08/08/23.
//

import UIKit

struct root: Codable{
    var login: String?
    var id: Int?
    var node_id: String?
    var url: String?
    var repos_url: String?
    var events_url: String?
    var hooks_url: String?
}


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return json?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "tablecell",for: indexPath)as! TableViewCell
        
        cell.label2.text = json?[indexPath.row].id?.description
        
        
        cell.label3.text = json?[indexPath.row].url
        return cell
    }
    
    
   
    
    override func viewDidLoad() {
        getdata()
        super.viewDidLoad()
        
    }
    var json : [root]?
    
    
    @IBOutlet weak var tableview: UITableView!
    
    
    func getdata(){
        let url = URL(string: "https://api.github.com/users/hadley/orgs")
        let task = URLSession.shared.dataTask(with: url!){
            (data,response,error) in
            do{
//                let content = try?JSONDecoder().decode([value].self, from: data!)
                let content = try? JSONDecoder().decode([root].self, from: data!)
                self.json = content
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
            }catch{
                    print(error)
                }
            }
        task.resume()
        }
        
    }
    

