//
//  SearchTableViewCell.swift
//  movieapp
//
//  Created by Олександр Олійник on 21.06.2022.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var searchMovieImage: UIImageView!
    
    @IBOutlet weak var searchMovieTitle: UILabel!
    
    @IBOutlet weak var searchMovieDescription: UILabel!
    
    @IBOutlet weak var searchMovieRating: UILabel!
    
    @IBOutlet weak var ratingImage: UIImageView!
    
    func setup(data: SearchingMovie) {
        self.searchMovieTitle.text = data.title ?? "No data"
        if (data.poster_path != nil) {
            let imageUrl = URL(string: "https://image.tmdb.org/t/p/original" + (data.poster_path!))
            self.searchMovieImage.sd_setImage(with: imageUrl)
        } else {
            self.searchMovieImage.image = UIImage(named: "no_image")
        }
        
        self.ratingImage.image = UIImage(systemName: "star.fill")
        self.ratingImage.tintColor = .yellow
        self.searchMovieImage.layer.cornerRadius = 10
        self.searchMovieDescription.text = data.overview!
        self.searchMovieRating.text = "\(data.vote_average!)"
    }
}
