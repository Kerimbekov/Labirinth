//
//  MapViewController.swift
//  Labirinth
//
//  Created by Нуржан Керимбеков on 2021-12-20.
//

import UIKit

class MapViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   

    @IBOutlet weak var mapTableView: UITableView!
    var matrix = [[Room]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        mapTableView.delegate = self
        mapTableView.dataSource = self
        mapTableView.register(UINib(nibName: "MapTableViewCell", bundle: nil), forCellReuseIdentifier: "MapTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matrix.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MapTableViewCell", for: indexPath) as! MapTableViewCell
        cell.roomList = matrix[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
 
}
