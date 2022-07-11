//
//  MovieInfoViewController.swift
//  movieapp
//
//  Created by Олександр Олійник on 03.07.2022.
//

import UIKit
import Alamofire

class MovieInfoViewController: UIViewController {
    
    var movieId = 0
    
    var castArr: [Cast] = []
    
    var genresList: [Genres] = []
    
    @IBOutlet weak var movieCastCollectionView: UICollectionView!
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieOverview: UILabel!
    
    @IBOutlet weak var tagline: UILabel!
    
    @IBOutlet weak var releaseDate: UILabel!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var genres: UILabel!
    
    @IBOutlet weak var movieRating: UILabel!
    
    @IBOutlet weak var numberOfVotes: UILabel!
    
    @IBOutlet weak var ratingImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup(movieId: movieId)
        requestCast(movieId: movieId)
//        try? realm?.write{
//            realm?.deleteAll()
//        }
    }
    
    
    @IBAction func addToWatchList(_ sender: Any) {
        let alertController = UIAlertController(title: "Successfull", message: "The movie added to watch list", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            
        }
        let movieId = self.movieId
        DataManager().save(movieId: movieId)
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
    
    @IBAction func trailerButton(_ sender: Any) {
        let nextController = storyboard?.instantiateViewController(withIdentifier: "TrailerViewController") as! TrailerViewController
        nextController.id = self.movieId
        navigationController?.present(nextController, animated: true)
    }
    
    private func setup(movieId: Int) {
        AF.request("\(Constants().address)/3/movie/\(movieId)?\(Constants().apiKey)&\(Constants().lang)", method: .get).responseJSON { response in
            let jsonDecoder = JSONDecoder()
            guard let responseData = response.data else { return }
            if let responseModel = try! jsonDecoder.decode(MovieInfoModel?.self, from: responseData) {
                if (responseModel.backdrop_path != nil){
                    guard let imageString = responseModel.backdrop_path else { return }
                    guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/original" + imageString) else { return }
                    self.movieImage.sd_setImage(with: imageUrl)
                    self.movieImage.contentMode = .scaleAspectFill
                } else {
                    self.movieImage.image = UIImage(named: "no_image")
                }
                self.releaseDate.text = responseModel.release_date ?? Constants().empty
                self.movieTitle.text = responseModel.title ?? Constants().empty
                self.tagline.text = responseModel.tagline ?? Constants().empty
                self.movieOverview.text = responseModel.overview ?? Constants().empty
                self.movieRating.text = "\(responseModel.vote_average!)"
                self.numberOfVotes.text = "(\(responseModel.vote_count!))"
                self.ratingImage.image = UIImage(systemName: "star.fill")
                self.ratingImage.tintColor = .yellow
                self.genresList = responseModel.genres ?? []
                for item in self.genresList {
                    self.genres.text = item.name
                }
                
            }
        }
    }
    private func requestCast(movieId: Int) {
        AF.request("https://api.themoviedb.org/3/movie/\(movieId)/credits?api_key=ab04cd0db471f8aec7ec3b6be80f900c&language=en-US", method: .get).responseJSON { response in
            let jsonDecoder = JSONDecoder()
            guard let responseData = response.data else { return }
            if let responseModel = try! jsonDecoder.decode(CastModel?.self, from: responseData) {
                self.castArr = responseModel.cast!
            }
            self.movieCastCollectionView.reloadData()
        }
    }
}


extension MovieInfoViewController: UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        castArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = movieCastCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCastCell", for: indexPath) as? MovieCastCell {
            cell.setup(data: castArr[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: movieCastCollectionView.frame.height, height: movieCastCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextController = storyboard?.instantiateViewController(withIdentifier: "ActorInfoViewController") as! ActorInfoViewController
        nextController.id = castArr[indexPath.row].id!
        navigationController?.show(nextController, sender: nil)
    }
}
