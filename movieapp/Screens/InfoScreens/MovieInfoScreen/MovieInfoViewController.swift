//
//  MovieInfoViewController.swift
//  movieapp
//
//  Created by Олександр Олійник on 03.07.2022.
//

import UIKit

class MovieInfoViewController: UIViewController {
    
    var movieId = 0
    
    let constants = Constants()
    
    let dataManager = DataManager()
    
    let networkManager = NetworkManager()
    
    var cast: [Cast] = []
    
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
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMovieInfoPage(movieId: movieId)
        setupMovieCastCollectionView(movieId: movieId)
    }
    
    // MARK: - Actions
    
    @IBAction func addToWatchList(_ sender: Any) {
        let alertController = UIAlertController(title: "Successfull", message: "The movie added to watch list", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { _ in }
        let movieId = self.movieId
        dataManager.save(movieId: movieId)
        alertController.addAction(action)
        self.present(alertController, animated: true)
    }
    // MARK: Navigation to trailer page
    @IBAction func trailerButton(_ sender: Any) {
        let nextController = storyboard?.instantiateViewController(withIdentifier: "TrailerViewController") as! TrailerViewController
        nextController.id = self.movieId
        navigationController?.present(nextController, animated: true)
    }
    
    // MARK: - Private Funcs
 
    private func setupMovieInfoPage(movieId: Int) {
        networkManager.requstInfo(infoRequest: "/3/movie/", id: movieId, model: MovieInfoModel?.self) { [self] response in
            if (response?.backdrop_path != nil){
                guard let imageString = response?.backdrop_path else { return }
                guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/original" + imageString) else { return }
                self.movieImage.sd_setImage(with: imageUrl)
                self.movieImage.contentMode = .scaleAspectFill
            } else {
                self.movieImage.image = UIImage(named: "no_image")
            }
            self.releaseDate.text = response?.release_date ?? constants.empty
            self.movieTitle.text = response?.title ?? constants.empty
            self.tagline.text = response?.tagline ?? constants.empty
            self.movieOverview.text = response?.overview ?? constants.empty
            self.movieRating.text = "\(response?.vote_average ?? 0)"
            self.numberOfVotes.text = "(\(response?.vote_count ?? 0))"
            self.ratingImage.image = UIImage(systemName: "star.fill")
            self.ratingImage.tintColor = .yellow
            self.genresList = response?.genres ?? []
            for item in genresList {
                self.genres.text! = item.name ?? " "
             }
        }
        
    }
    
    private func setupMovieCastCollectionView(movieId: Int) {
        networkManager.requestCastInfo(infoRequest: "/3/movie/", id: movieId, model: CastModel?.self) { response in
            self.cast = response?.cast ?? []
            self.movieCastCollectionView.reloadData()
        }
    }
}

extension MovieInfoViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = movieCastCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCastCell", for: indexPath) as? MovieCastCell {
            cell.setup(data: cast[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

extension MovieInfoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cast.count
    }
    // MARK: Navigation to actor page
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let nextController = storyboard?.instantiateViewController(withIdentifier: "ActorInfoViewController") as? ActorInfoViewController else { return }
        guard let transmittedId = cast[indexPath.row].id else { return }
        nextController.id = transmittedId
        navigationController?.show(nextController, sender: nil)
    }
}

extension MovieInfoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let actorCellHeight = movieCastCollectionView.frame.height
        //let actorCellWidth = movieCastCollectionView.frame.width
        return CGSize(width: actorCellHeight, height: actorCellHeight)
    }
}
