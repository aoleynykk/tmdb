//
//  NowPlayingMovieCollectionViewCell.swift
//  movieapp
//
//  Created by Олександр Олійник on 20.06.2022.
//

import UIKit
import Alamofire
class NowPlayingMovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nowPlayingMovieImage: UIImageView!
    
    @IBOutlet weak var nowPlayingMovieTitle: UILabel!
    
    @IBOutlet weak var nowPlayingMovieRating: UILabel!
    
    func setup(data: NowPlayingMovie) {
        guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/original" + data.poster_path!) else { return }
        self.nowPlayingMovieImage.sd_setImage(with: imageUrl)
        self.nowPlayingMovieTitle.text = data.title ?? "NO DATA"
        self.nowPlayingMovieRating.text = "\(data.vote_average!)"
        
    }
}
