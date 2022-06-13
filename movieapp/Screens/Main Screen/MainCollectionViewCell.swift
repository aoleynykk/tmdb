//
//  MainCollectionViewCell.swift
//  movieapp
//
//  Created by Олександр Олійник on 13.06.2022.
//

import UIKit
import SDWebImage

class MainCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var trendingMovieImage: UIImageView!
    
    @IBOutlet weak var trendingMovieTitle: UILabel!
 
    @IBOutlet weak var trendingMovieRating: UILabel!
    
    func setup(data: TrendingMovie) {
        self.trendingMovieTitle.text = data.title ?? " "
        self.trendingMovieRating.text = "\(data.vote_average ?? 0)"
        //let imageStringUrl = data.image
        //guard let imageUrl = URL(string: imageStringUrl!) else { return }
        //webImage.sd_setImage(with: imageUrl)
        guard let imageStringUrl  = data.poster_path else { return }
        guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + imageStringUrl) else { return }
        self.trendingMovieImage.sd_setImage(with: imageUrl)
        
    }
    
}
