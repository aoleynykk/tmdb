//
//  MovieInfoViewController.swift
//  movieapp
//
//  Created by Олександр Олійник on 21.06.2022.
//

import UIKit
import Alamofire
import youtube_ios_player_helper

class MovieInfoViewController: UIViewController {

    @IBOutlet weak var movieImageTwo: UIImageView!
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var movieDate: UILabel!
    
    @IBOutlet weak var movieRating: UILabel!
    
    @IBOutlet weak var movieTagline: UILabel!
    
    @IBOutlet weak var movieDescription: UILabel!
    
    @IBOutlet weak var movieTime: UILabel!
    
    @IBOutlet weak var movieCompanyOne: UIImageView!
    
    @IBOutlet weak var movieCompanyTwo: UIImageView!
    
    @IBOutlet weak var movieCompanyThree: UIImageView!
    
    @IBOutlet weak var movieTrailer: YTPlayerView!
    
    var movieID: Int = 0
    
    @IBOutlet weak var button: UIButton!
    
    @IBAction func saveButton(_ sender: Any) {
        let parameters: [String: Any] = [
            "id": self.movieID,
            "title": self.movieTitle.text!,
            "poster_path": "NO IMAGE",
            "vote_average": (self.movieRating.text! as NSString).intValue,
            "overview": self.movieDescription.text!
        ]
        addToWatchList(parameters: parameters)
        if button.tintColor == .white {
            button.tintColor = .red
        } else if button.tintColor == .red {
            button.tintColor = .white
        }
    }
 
    
    
    
    private func addToWatchList(parameters: [String: Any]){
        AF.request("https://tmdbapi.azurewebsites.net/AddToWatchList", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            //print(response)
        }
    }
    
    
    var trailers: [MovieVideo] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setup(movieID: movieID)
        
    }
    
    private func setup(movieID: Int) {
        AF.request("https://tmdbapi.azurewebsites.net/MovieInfo?movieId=\(movieID)", method: .get).responseJSON { response in
            let jsonDecoder = JSONDecoder()
            guard let responseData = response.data else { return }
            if let responseModel = try! jsonDecoder.decode(MovieInfoModel?.self, from: responseData) {
                if (responseModel.poster_path != nil) {
                    let imageUrl = URL(string: "https://image.tmdb.org/t/p/original" + (responseModel.poster_path!))
                    self.movieImage.sd_setImage(with: imageUrl)
                    self.movieImage.sd_setImage(with: imageUrl)
                } else {
                    self.movieImage.image = UIImage(named: "no_image")
                    self.movieImageTwo.image = UIImage(named: "no_image")
                }
                self.movieRating.text = "\(responseModel.vote_average!)"
                self.movieDescription.text = responseModel.overview!
                self.movieDate.text = responseModel.release_date!
                self.movieTagline.text = responseModel.tagline!
                self.movieTime.text = "\(responseModel.runtime!) minutes"
                self.movieTitle.text = responseModel.title!
                let controller = self.storyboard?.instantiateViewController(withIdentifier: "WatchListViewController") as! WatchListViewController
                controller.Id = responseModel.id!
                
            }
        }
        AF.request("https://tmdbapi.azurewebsites.net//MovieVideo?movieId=\(movieID)", method: .get).responseJSON { response in
            let jsonDecoder = JSONDecoder()
            guard let responseData = response.data else { return }
            if let responseModel = try! jsonDecoder.decode(MovieVideoModel?.self, from: responseData){
                self.trailers = responseModel.results!
                
            }
            for item in self.trailers {
                if item.type == "Trailer"{
                    self.movieTrailer.load(withVideoId: item.key!)
                }
            }
        }
    }
}
