//
//  TrendingMovieCollectionViewCell.swift
//  movieapp
//
//  Created by Олександр Олійник on 16.06.2022.
//

import UIKit

class TrendingMovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var trendingMovieImage: UIImageView!
    
    func setup(data: MainScreenMovie) {
        if (data.poster_path != nil) {
            guard let imageString = data.poster_path else { return }
            guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/original" + imageString) else { return }
            self.trendingMovieImage.sd_setImage(with: imageUrl)
        } else {
            self.trendingMovieImage.image = UIImage(named: "no_image")
        }
    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        self.layer.cornerRadius = 10
//        layer.shadowOpacity = 0.3
//        self.layer.shadowRadius = 10
//        self.layer.shadowColor = CGColor(red: 100, green: 100, blue: 100, alpha: 0)
//        layer.shadowOffset = CGSize(width: 5, height: 5)
//        self.clipsToBounds = false
//    }
}
