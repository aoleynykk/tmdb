//
//  Constants.swift
//  movieapp
//
//  Created by Олександр Олійник on 13.06.2022.
//

import UIKit
import Foundation

struct Constants {
    let url = "https://api.themoviedb.org/3/trending/all/day?api_key=ab04cd0db471f8aec7ec3b6be80f900c"
    func screenHeight() -> CGFloat {
        return UIScreen.main.bounds.size.height
    }

    func screenWidth() -> CGFloat {
        return UIScreen.main.bounds.size.width
    }
//    let screen = UIScreen.main.bounds
//    let screenWidth = screen.size.width
//    let screenHeight = screen.size.height
}
