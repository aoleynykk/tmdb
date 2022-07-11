//
//  WatchListViewController.swift
//  movieapp
//
//  Created by Олександр Олійник on 17.06.2022.
//

import UIKit

class WatchListViewController: UIViewController {

    let dataManager = DataManager()
    
    @IBOutlet weak var watchListTableView: UITableView!
    
    var watchList: [WatchListMovie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        watchList = DataManager().getWatchList()
        watchListTableView.register(UINib(nibName: "WatchListCell", bundle: nil), forCellReuseIdentifier: "WatchListCell")
    }
    
    @IBAction func deleteFromWatchList(_ sender: Any) {
        let edit = !self.watchListTableView.isEditing
        self.watchListTableView.setEditing(edit, animated: true)
    }
}

extension WatchListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watchList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextController = storyboard?.instantiateViewController(withIdentifier: "MovieInfoViewController") as! MovieInfoViewController
        nextController.movieId = watchList[indexPath.row].id
        navigationController?.show(nextController, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = watchListTableView.dequeueReusableCell(withIdentifier: "WatchListCell", for: indexPath) as? WatchListCell {
            cell.layer.cornerRadius = 10
            cell.setup(id: watchList[indexPath.row].id)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataManager.delete(movieToDelete: self.watchList[indexPath.row])
        }
        self.watchListTableView.reloadData()
    }
}
