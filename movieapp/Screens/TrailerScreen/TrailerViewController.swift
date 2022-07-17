//
//  TrailerScreenViewController.swift
//  movieapp
//
//  Created by Олександр Олійник on 06.07.2022.
//

import UIKit
import youtube_ios_player_helper

class TrailerViewController: UIViewController {
    
    @IBOutlet weak var movieTrailer: YTPlayerView!
        
    var id = 0
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.requestTrailer(id: id, trailer: movieTrailer)
    }
}



