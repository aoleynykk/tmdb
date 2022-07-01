//
//  WatchListCell.swift
//  movieapp
//
//  Created by Олександр Олійник on 19.06.2022.
//

import UIKit
import Alamofire

class WatchListCell: UITableViewCell {
    
    
    
    @IBOutlet weak var watchListImage: UIImageView!
    
    @IBOutlet weak var watchListTitle: UILabel!
    
    @IBOutlet weak var watchListDescription: UITextView!
    
    @IBOutlet weak var watchListRating: UILabel!
    
    @IBOutlet weak var ratingImage: UIImageView!
    
    
    
    
//    private func deleteMovieFromWatchList(id: Int){
//        AF.request("https://tmdbapi.azurewebsites.net/DeleteFromWatchList?\(id)", method: .delete, encoding: JSONEncoding.default).responseJSON { response in }
//    }
    func setup(data: WatchListMovie) {
        
        self.watchListDescription.text = data.overview!
        self.watchListTitle.text = data.title!
        self.watchListRating.text = "\(data.vote_average!)"
        self.ratingImage.image = UIImage(systemName: "star.fill")
    }
}
