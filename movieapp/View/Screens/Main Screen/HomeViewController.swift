//
//  ViewController.swift
//  movieapp
//
//  Created by Олександр Олійник on 11.06.2022.
//

import UIKit
import Alamofire


class HomeViewController: UIViewController {
    
    var listOfUpcomingMovies: [UpcomingMovie] = []
    
    var listOfNowPlayingMovies: [NowPlayingMovie] = []
    
    var listOfTrendingMovies: [TrendingMovie] = []
    
    
    
    @IBOutlet weak var upcomingMovieCollectionView: UICollectionView!
    
    @IBOutlet weak var nowPlayingMovieCollectionView: UICollectionView!
    
    @IBOutlet weak var trendingMovieCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCells()
    }
    
    private func configureCells() {
        registerCells()
        requestTrendingMovies()
        requestNowPlayingMovies()
        requestUpcomingMovies()
       
    }
    private func registerCells() {
        nowPlayingMovieCollectionView.register(UINib(nibName: "NowPlayingMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NowPlayingMovieCollectionViewCell")
        trendingMovieCollectionView.register(UINib(nibName: "TrendingMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TrendingMovieCollectionViewCell")
        upcomingMovieCollectionView.register(UINib(nibName: "UpcomingMovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UpcomingMovieCollectionViewCell")
    }
    private func configureCollectionView(){
        
        //        self.collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.5).isActive = true
        
        //        self.collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        //        self.collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        //        self.collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
//    private func CustomizeCell(_ cell: UICollectionViewCell) {
//        cell.layer.shadowColor = UIColor.black.cgColor
//        cell.layer.shadowOpacity = 0.1
//        cell.layer.shadowRadius = 10
//        cell.layer.shadowOffset = .zero
//    }
    
}
extension HomeViewController: UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case upcomingMovieCollectionView:
            return self.listOfUpcomingMovies.count
        case nowPlayingMovieCollectionView:
            return self.listOfNowPlayingMovies.count
        case trendingMovieCollectionView:
            return self.listOfTrendingMovies.count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "MovieInfoViewController") as! MovieInfoViewController
        //controller.modalPresentationStyle = .fullScreen
        switch collectionView {
        case nowPlayingMovieCollectionView:
            controller.movieID = listOfNowPlayingMovies[indexPath.row].id!
        case trendingMovieCollectionView:
            controller.movieID = listOfTrendingMovies[indexPath.row].id!
        case upcomingMovieCollectionView:
            controller.movieID = listOfUpcomingMovies[indexPath.row].id!
        default:
            return
        }
        navigationController?.present(controller, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case trendingMovieCollectionView:
            let cell = trendingMovieCollectionView.dequeueReusableCell(withReuseIdentifier: "TrendingMovieCollectionViewCell", for: indexPath) as! TrendingMovieCollectionViewCell
            //CustomizeCell(cell)
            cell.setup(data: self.listOfTrendingMovies[indexPath.row])
            return cell
            
        case nowPlayingMovieCollectionView:
            let cell = nowPlayingMovieCollectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingMovieCollectionViewCell", for: indexPath) as! NowPlayingMovieCollectionViewCell
           // CustomizeCell(cell)
            cell.setup(data: self.listOfNowPlayingMovies[indexPath.row])
            return cell
        case upcomingMovieCollectionView:
            let cell = upcomingMovieCollectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingMovieCollectionViewCell", for: indexPath) as! UpcomingMovieCollectionViewCell
           // CustomizeCell(cell)
            cell.setup(data: self.listOfUpcomingMovies[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case nowPlayingMovieCollectionView:
            return CGSize(width: Constants().screenWidth()/1.15, height: Constants().screenHeight()/3)
        case trendingMovieCollectionView:
            return CGSize(width: Constants().screenWidth()/1.15, height: Constants().screenHeight()/3)
        case upcomingMovieCollectionView:
            return CGSize(width: Constants().screenWidth()/1.8, height: Constants().screenHeight()/2)
        default:
            return CGSize(width: 200, height: 250)
        }
    }
    
    
    // MARK: - NETWORKING
    
    func requestUpcomingMovies() {
        AF.request("https://tmdbapi.azurewebsites.net/UpcomingMovies", method: .get).responseJSON { response in
            let jsonDecoder = JSONDecoder()
            guard let responseData = response.data else { return }
            if let responseModel = try! jsonDecoder.decode(UpcomingMovieModel?.self, from: responseData) {
                self.listOfUpcomingMovies = responseModel.results!
            }
            DispatchQueue.main.async {
                self.upcomingMovieCollectionView.reloadData()
            }
        }
    }
    
    func requestNowPlayingMovies() {
        AF.request("https://tmdbapi.azurewebsites.net/NowPlayingMovies", method: .get).responseJSON { response in
            let jsonDecoder = JSONDecoder()
            guard let responseData = response.data else { return }
            if let responseModel = try! jsonDecoder.decode(NowPlayingMovieModel?.self, from: responseData) {
                self.listOfNowPlayingMovies = responseModel.results!
            }
            DispatchQueue.main.async {
                self.nowPlayingMovieCollectionView.reloadData()
            }
        }
    }
    func requestTrendingMovies() {
        AF.request("https://tmdbapi.azurewebsites.net/TrendingMovies", method: .get).responseJSON { response in
            let jsonDecoder = JSONDecoder()
            guard let responseData = response.data else { return }
            if let responseModel = try! jsonDecoder.decode(TrendingMovieModel?.self, from: responseData) {
                self.listOfTrendingMovies = responseModel.results!
            }
            DispatchQueue.main.async {
                self.trendingMovieCollectionView.reloadData()
            }
        }
    }
}

