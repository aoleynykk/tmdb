//
//  NetworkManeger.swift
//  movieapp
//
//  Created by Олександр Олійник on 25.06.2022.
//

import UIKit
import Alamofire


struct NetworkManeger {
    
    func requestUpcomingMovies(collectionView: UICollectionView) -> [UpcomingMovie] {
        var list: [UpcomingMovie] = []
        AF.request("https://tmdbapi.azurewebsites.net/UpcomingMovies", method: .get).responseJSON { response in
            let jsonDecoder = JSONDecoder()
            guard let responseData = response.data else { return }
            if let responseModel = try! jsonDecoder.decode(UpcomingMovieModel?.self, from: responseData) {
                list = responseModel.results!
            }
            
        }
        return list
    }
    
    func requestNowPlayingMovies(collectionView: UICollectionView) -> [NowPlayingMovie] {
        var list: [NowPlayingMovie] = []
        AF.request("https://tmdbapi.azurewebsites.net/NowPlayingMovies", method: .get).responseJSON { response in
            let jsonDecoder = JSONDecoder()
            guard let responseData = response.data else { return }
            if let responseModel = try! jsonDecoder.decode(NowPlayingMovieModel?.self, from: responseData) {
                list = responseModel.results!
            }
            DispatchQueue.main.async {
                collectionView.reloadData()
            }
        }
        return list
    }
    
    func requestTrendingMovies() -> [TrendingMovie] {
        var list: [TrendingMovie] = []
        AF.request("https://tmdbapi.azurewebsites.net/TrendingMovies", method: .get).responseJSON { response in
            let jsonDecoder = JSONDecoder()
            guard let responseData = response.data else { return }
            if let responseModel = try! jsonDecoder.decode(TrendingMovieModel?.self, from: responseData) {
                list = responseModel.results!
            }
        }
        return list
    }
}
