//
//  NowPlayingMovieCollectionViewCell.swift
//  movieapp
//
//  Created by Олександр Олійник on 20.06.2022.
//

import UIKit

class NowPlayingMovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nowPlayingMovieImage: UIImageView!
    
    func setup(data: MainScreenMovie) {
        if (data.poster_path != nil) {
            guard let imageString = data.poster_path else { return }
            guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/original" + imageString) else { return }
            self.nowPlayingMovieImage.sd_setImage(with: imageUrl)
        } else {
            self.nowPlayingMovieImage.image = UIImage(named: "no_image")
        }
    }
}
