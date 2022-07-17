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
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCells()
    }
    
    //MARK: - Private Funcs
    
    private func configureCells() {
        NetworkManager.shared.mainScreenMovieRequest(infoRequest: "/3/movie/upcoming", model: MainScreenMovieModel?.self) { response in
            self.listOfUpcomingMovies = response?.results ?? []
            self.upcomingMovieCollectionView.reloadData()

        }
        NetworkManager.shared.mainScreenMovieRequest(infoRequest: "/3/movie/now_playing", model: MainScreenMovieModel?.self) { response in
            self.listOfNowPlayingMovies = response?.results ?? []
            self.nowPlayingMovieCollectionView.reloadData()

        }
        NetworkManager.shared.mainScreenMovieRequest(infoRequest: "/3/trending/movie/week", model: MainScreenMovieModel?.self) { response in
            self.listOfTrendingMovies = response?.results ?? []
            self.trendingMovieCollectionView.reloadData()
        }
    }
}
extension HomeViewController: UICollectionViewDataSource {
    
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
        default: return UICollectionViewCell() }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case upcomingMovieCollectionView:
            return self.listOfUpcomingMovies.count
        case nowPlayingMovieCollectionView:
            return self.listOfNowPlayingMovies.count
        case trendingMovieCollectionView:
            return self.listOfTrendingMovies.count
        default: return 0 }
    }
    //MARK: Navigation to info page
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextController = storyboard?.instantiateViewController(withIdentifier: "MovieInfoViewController") as! MovieInfoViewController
        switch collectionView {
        case nowPlayingMovieCollectionView:
            guard let transmittedId = listOfNowPlayingMovies[indexPath.row].id else { return }
            nextController.movieId = transmittedId
        case trendingMovieCollectionView:
            guard let transmittedId = listOfTrendingMovies[indexPath.row].id else { return }
            nextController.movieId = transmittedId
        case upcomingMovieCollectionView:
            guard let transmittedId = listOfUpcomingMovies[indexPath.row].id else { return }
            nextController.movieId = transmittedId
        default: return }
        navigationController?.show(nextController, sender: nil)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case nowPlayingMovieCollectionView:
            return CGSize(width: self.nowPlayingMovieCollectionView.frame.height/1.5, height: self.nowPlayingMovieCollectionView.frame.height)
        case trendingMovieCollectionView:
            return CGSize(width: self.trendingMovieCollectionView.frame.height/1.5, height: self.trendingMovieCollectionView.frame.height)
        case upcomingMovieCollectionView:
            return CGSize(width: self.upcomingMovieCollectionView.frame.height/1.5, height: self.upcomingMovieCollectionView.frame.height)
        default:
            return CGSize(width: 200, height: 250)
        }
    }
}
