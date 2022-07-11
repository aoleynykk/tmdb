//
//  MovieCastCell.swift
//  movieapp
//
//  Created by Олександр Олійник on 05.07.2022.
//

import UIKit

class MovieCastCell: UICollectionViewCell {
    @IBOutlet weak var actorCell: UIImageView!
    
    func setup(data: Cast) {
        if (data.profile_path != nil) {
            guard let imageString = data.profile_path else { return }
            guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/original" + imageString) else { return }
            self.actorCell.sd_setImage(with: imageUrl)

        } else {
            self.actorCell.image = UIImage(named: "no_image")
        }
    }
}
