//
//  WatchListViewController.swift
//  movieapp
//
//  Created by Олександр Олійник on 17.06.2022.
//

import UIKit

class WatchListViewController: UIViewController {

    @IBOutlet weak var watchListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        watchListTableView.register(UINib(nibName: "WatchListCell", bundle: nil), forCellReuseIdentifier: "WatchListCell")
    }
    

    
}
extension WatchListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = watchListTableView.dequeueReusableCell(withIdentifier: "WatchListCell", for: indexPath) as? WatchListCell {
            cell.layer.cornerRadius = 10
            //cell.clipsToBounds = true
            
            return cell
        }
        return UITableViewCell()
    }
}
