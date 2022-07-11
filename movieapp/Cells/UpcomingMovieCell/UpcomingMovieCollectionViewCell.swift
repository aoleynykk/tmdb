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
    
    
    func setup(data: MainScreenMovie) {
        if (data.poster_path != nil) {
            guard let imageString = data.poster_path else { return }
            guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/original" + imageString) else { return }
            self.upcomingMovieImage.sd_setImage(with: imageUrl)
        } else {
            self.upcomingMovieImage.image = UIImage(named: "no_image")
        }
    }
}
