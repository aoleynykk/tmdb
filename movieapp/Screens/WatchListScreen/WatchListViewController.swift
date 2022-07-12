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
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        watchList = dataManager.getWatchList()
        registerCell()
    }
    
    // MARK: - Actions
    
    @IBAction func deleteFromWatchList(_ sender: Any) {
        let edit = !self.watchListTableView.isEditing
        self.watchListTableView.setEditing(edit, animated: true)
    }
    
    //MARK: - Private Funcs
    
    private func registerCell() {
        let nib = UINib(nibName: "WatchListCell", bundle: nil)
        watchListTableView.register(nib, forCellReuseIdentifier: "WatchListCell")
    }
}

extension WatchListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = watchListTableView.dequeueReusableCell(withIdentifier: "WatchListCell", for: indexPath) as? WatchListCell {
            cell.setup(id: watchList[indexPath.row].id)
            return cell
        }
        return UITableViewCell()
    }
}

extension WatchListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watchList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.watchListTableView.frame.width/2
    }
    //MARK: NAvigation to info page
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let nextController = storyboard?.instantiateViewController(withIdentifier: "MovieInfoViewController") as? MovieInfoViewController else { return }
        nextController.movieId = watchList[indexPath.row].id
        navigationController?.show(nextController, sender: nil)
    }
    //MARK: Delete from db(watchList)
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataManager.delete(movieToDelete: self.watchList[indexPath.row])
        }
        self.watchListTableView.reloadData()
    }
}
