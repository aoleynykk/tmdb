//
//  WatchListViewController.swift
//  movieapp
//
//  Created by Олександр Олійник on 17.06.2022.
//

import UIKit
import Alamofire

class WatchListViewController: UIViewController {
    
    @IBOutlet weak var watchListTableView: UITableView!
    
    var Id: Int = 0
    
    var watchList: [WatchListMovie] = []
    
    private var movieDescription: String = " "
    override func viewDidLoad() {
        super.viewDidLoad()
        
        watchListTableView.register(UINib(nibName: "WatchListCell", bundle: nil), forCellReuseIdentifier: "WatchListCell")
        loadWatchList()
    }
    
    
    private func loadWatchList() {
        let url = "https://tmdbapi.azurewebsites.net/GetWatchList"
        AF.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            print(response)
            let jsonDecoder = JSONDecoder()
            guard let responseData = response.data else { return }
            if let responseModel = try! jsonDecoder.decode([WatchListMovie]?.self, from: responseData) {
                self.watchList = responseModel
            }
            DispatchQueue.main.async {
                self.watchListTableView.reloadData()
            }
        }
    }
}
extension WatchListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.watchList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "MovieInfoViewController") as! MovieInfoViewController
        //controller.modalPresentationStyle = .fullScreen
        controller.movieID = watchList[indexPath.row].id!
        navigationController?.present(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = watchListTableView.dequeueReusableCell(withIdentifier: "WatchListCell", for: indexPath) as? WatchListCell {
            cell.layer.cornerRadius = 10
            //cell.clipsToBounds = true
            
            cell.setup(data: watchList[indexPath.row])
            
            return cell
        }
        return UITableViewCell()
    }
    
//    private func reloadWatchList(movieID: Int) {
//        AF.request("https://tmdbapi.azurewebsites.net/MovieInfo?movieId=\(movieID)").responseJSON {
//            response in
//            let jsonDecoder = JSONDecoder()
//            guard let responseData = response.data else { return }
//            if let responseModel = try! jsonDecoder.decode(MovieInfoModel?.self, from: responseData) {
//                self.movieImage = responseModel.poster_path!
//                self.movieRating = responseModel.vote_average!
//                self.movieTitle = responseModel.title!
//                self.movieDescription = responseModel.overview!
//            }
//            DispatchQueue.main.async {
//                self.watchListTableView.reloadData()
//            }
//        }
//    }
}
