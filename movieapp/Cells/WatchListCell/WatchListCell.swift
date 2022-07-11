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
    
    func setup(id: Int) {
        AF.request("\(Constants().address)/3/movie/\(id)?api_key=\(Constants().apiKey)&\(Constants().lang)", method: .get).responseJSON { response in
            let jsonDecoder = JSONDecoder()
            guard let responseData = response.data else { return }
            if let responseModel = try! jsonDecoder.decode(MovieInfoModel?.self, from: responseData) {
                if (responseModel.poster_path != nil){
                    guard let imageString = responseModel.poster_path else { return }
                    guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/original" + imageString) else { return }
                    self.watchListImage.sd_setImage(with: imageUrl)
                    self.watchListImage.contentMode = .scaleAspectFill
                } else {
                    self.watchListImage.image = UIImage(named: "no_image")
                    self.watchListImage.contentMode = .scaleAspectFill
                }
                self.watchListTitle.text = responseModel.title ?? Constants().empty
                //self.watchListDescription.text = responseModel.overview ?? Constants().empty
                self.watchListRating.text = "\(responseModel.vote_average!)"
                self.ratingImage.image = UIImage(systemName: "star.fill")
                self.ratingImage.tintColor = .yellow
            }
        }
    }
}


