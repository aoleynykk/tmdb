//
//  ViewController.swift
//  movieapp
//
//  Created by Олександр Олійник on 11.06.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    var listOfUpcomingMovies: [MainScreenMovie] = []
    
    var listOfNowPlayingMovies: [MainScreenMovie] = []
    
    var listOfTrendingMovies: [MainScreenMovie] = []
    
    @IBOutlet weak var upcomingMovieCollectionView: UICollectionView!
    
    @IBOutlet weak var nowPlayingMovieCollectionView: UICollectionView!
    
    @IBOutlet weak var trendingMovieCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCells()
        
    }
    
    private func configureCells() {
        let networkManager = NetworkManager()
        networkManager.mainScreenMovieRequest(infoRequest: "/3/movie/upcoming", model: MainScreenMovieModel?.self) { response in
            self.listOfUpcomingMovies = response?.results ?? []
            self.upcomingMovieCollectionView.reloadData()

        }
        networkManager.mainScreenMovieRequest(infoRequest: "/3/movie/now_playing", model: MainScreenMovieModel?.self) { response in
            self.listOfNowPlayingMovies = response?.results ?? []
            self.nowPlayingMovieCollectionView.reloadData()

        }
        networkManager.mainScreenMovieRequest(infoRequest: "/3/trending/movie/week", model: MainScreenMovieModel?.self) { response in
            self.listOfTrendingMovies = response?.results ?? []
            self.trendingMovieCollectionView.reloadData()
        }
    }
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
        let nextController = storyboard?.instantiateViewController(withIdentifier: "MovieInfoViewController") as! MovieInfoViewController
        switch collectionView {
        case nowPlayingMovieCollectionView:
            nextController.movieId = listOfNowPlayingMovies[indexPath.row].id!
        case trendingMovieCollectionView:
            nextController.movieId = listOfTrendingMovies[indexPath.row].id!
        case upcomingMovieCollectionView:
            nextController.movieId = listOfUpcomingMovies[indexPath.row].id!
        default:
            return
        }
        navigationController?.show(nextController, sender: nil)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case trendingMovieCollectionView:
            let cell = trendingMovieCollectionView.dequeueReusableCell(withReuseIdentifier: "TrendingMovieCollectionViewCell", for: indexPath) as! TrendingMovieCollectionViewCell
            cell.setup(data: self.listOfTrendingMovies[indexPath.row])
            return cell
            
        case nowPlayingMovieCollectionView:
            let cell = nowPlayingMovieCollectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingMovieCollectionViewCell", for: indexPath) as! NowPlayingMovieCollectionViewCell
            cell.setup(data: self.listOfNowPlayingMovies[indexPath.row])
            return cell
        case upcomingMovieCollectionView:
            let cell = upcomingMovieCollectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingMovieCollectionViewCell", for: indexPath) as! UpcomingMovieCollectionViewCell
            cell.setup(data: self.listOfUpcomingMovies[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case nowPlayingMovieCollectionView:
            return CGSize(width: Constants().screenWidth()*0.6, height: Constants().screenHeight()/2.5)
        case trendingMovieCollectionView:
            return CGSize(width: Constants().screenWidth()*0.6, height: Constants().screenHeight()/2.5)
        case upcomingMovieCollectionView:
            return CGSize(width: Constants().screenWidth()*0.7, height: Constants().screenHeight()/2.1)
        default:
            return CGSize(width: 200, height: 250)
        }
    }
}
