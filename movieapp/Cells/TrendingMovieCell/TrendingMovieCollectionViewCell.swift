//
//  TrendingMovieCollectionViewCell.swift
//  movieapp
//
//  Created by Олександр Олійник on 16.06.2022.
//

import UIKit

class TrendingMovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var trendingMovieImage: UIImageView!
    
    @IBOutlet weak var trendingMovieTitle: UILabel!
    
    @IBOutlet weak var trendingMovieRating: UILabel!
    
    func setup(data: TrendingMovie) {
        guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/original" + data.poster_path!) else { return }
        self.trendingMovieImage.sd_setImage(with: imageUrl)
        self.trendingMovieTitle.text = data.title ?? "NO DATA"
        self.trendingMovieRating.text = "Рейтинг: \(data.vote_average!)"
    }

}
