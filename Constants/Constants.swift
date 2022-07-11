//
//  Constants.swift
//  movieapp
//
//  Created by Олександр Олійник on 13.06.2022.
//

import Foundation
import UIKit

struct Constants {
    let apiKey = "api_key=ab04cd0db471f8aec7ec3b6be80f900c"
    let address = "https://api.themoviedb.org"
    let empty = "NO DATA"
    let lang = "&language=en-US"
    
    func screenHeight() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    func screenWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
}
