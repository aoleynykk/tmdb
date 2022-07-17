//
//  WatchListCell.swift
//  movieapp
//
//  Created by Олександр Олійник on 19.06.2022.
//

import UIKit
import Alamofire

class WatchListCell: UITableViewCell {
    
    //let networkManager = NetworkManager()

    @IBOutlet weak var watchListImage: UIImageView!
    
    @IBOutlet weak var watchListTitle: UILabel!
    
    @IBOutlet weak var watchListDescription: UITextView!
    
    @IBOutlet weak var watchListRating: UILabel!
    
    @IBOutlet weak var ratingImage: UIImageView!
    
    func setup(id: Int) {
        NetworkManager.shared.requstInfo(infoRequest: "/3/movie/", id: id, model: MovieInfoModel?.self) { response in
            if (response?.poster_path != nil){
                guard let imageString = response?.poster_path else { return }
                guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/original" + imageString) else { return }
                self.watchListImage.sd_setImage(with: imageUrl)
                self.watchListImage.contentMode = .scaleAspectFill
            } else {
                self.watchListImage.image = UIImage(named: "no_image")
                self.watchListImage.contentMode = .scaleAspectFill
            }
            self.watchListTitle.text = response?.title ?? Constants().empty
            //self.watchListDescription.text = responseModel.overview ?? Constants().empty
            self.watchListRating.text = "\(response?.vote_average ?? 0)"
            self.ratingImage.image = UIImage(systemName: "star.fill")
            self.ratingImage.tintColor = .yellow
        }
    }
}


