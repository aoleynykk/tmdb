//
//  Cell.swift
//  movieapp
//
//  Created by Олександр Олійник on 11.06.2022.
//

import UIKit

class Cell: UICollectionViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieName: UILabel!
    
    @IBOutlet weak var movieRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
