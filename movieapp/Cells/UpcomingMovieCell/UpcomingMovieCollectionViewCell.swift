//
//  UpcomingMovieCollectionViewCell.swift
//  movieapp
//
//  Created by Олександр Олійник on 20.06.2022.
//

import UIKit
import SDWebImage

class UpcomingMovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var upcomingMovieImage: UIImageView!
    
    @IBOutlet weak var upcomingMovieTitle: UILabel!
    
    @IBOutlet weak var movieReleaseDate: UILabel!
    
    func setup(data: UpcomingMovie) {
        guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/original" + data.poster_path!) else { return }
        self.upcomingMovieImage.sd_setImage(with: imageUrl)
        self.upcomingMovieTitle.text = data.title ?? "NO DATA"
        self.movieReleaseDate.text = data.release_date ?? "NO DATA"
    }
}
