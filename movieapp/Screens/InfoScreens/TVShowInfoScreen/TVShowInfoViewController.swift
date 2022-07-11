//
//  TVShowInfoViewController.swift
//  movieapp
//
//  Created by Олександр Олійник on 09.07.2022.
//

import UIKit

class TVShowInfoViewController: UIViewController {
    var tvShowId = 0
    
    let networkManager = NetworkManager()
    
    var castArr: [Cast] = []
    
    @IBOutlet weak var tvShowImage: UIImageView!
    
    @IBOutlet weak var tvShowCastCollectionView: UICollectionView!
    
    @IBOutlet weak var tvShowSeasons: UILabel!
    
    @IBOutlet weak var tvShowCountOfVotes: UILabel!
    
    @IBOutlet weak var tvShowRating: UILabel!
    
    @IBOutlet weak var ratingImage: UIImageView!
    
    @IBOutlet weak var tvShowTitle: UILabel!
    
    @IBOutlet weak var tvShowTagline: UILabel!
    
    @IBOutlet weak var tvShowOverview: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInfoPage(tvShowId: tvShowId)
        requestCast(tvShowId: tvShowId)
    }
    
    @IBAction func trailerButton(_ sender: Any) {
        let nextController = storyboard?.instantiateViewController(withIdentifier: "TrailerViewController") as! TrailerViewController
        nextController.id = self.tvShowId
        navigationController?.present(nextController, animated: true)
    }
    
    private func setupInfoPage(tvShowId: Int) {
        networkManager.requstInfo(infoRequest: "/3/tv/", id: tvShowId, model: tvShowInfoModel?.self) { response in
            if (response?.backdrop_path != nil){
                guard let imageString = response?.backdrop_path else { return }
                guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/original" + imageString) else { return }
                self.tvShowImage.sd_setImage(with: imageUrl)
                self.tvShowImage.contentMode = .scaleAspectFill
            } else {
                self.tvShowImage.image = UIImage(named: "no_image")
            }
            self.tvShowSeasons.text = "\(response?.number_of_seasons ?? 0) seasons \(response?.number_of_episodes ?? 0) episodes"
            self.tvShowTitle.text = response?.name ?? Constants().empty
            self.tvShowTagline.text = response?.tagline ?? Constants().empty
            self.tvShowOverview.text = response?.overview ?? Constants().empty
            self.tvShowRating.text = "\(response?.vote_average ?? 0)"
            self.tvShowCountOfVotes.text = "(\(response?.vote_count ?? 0))"
            self.ratingImage.image = UIImage(systemName: "star.fill")
            self.ratingImage.tintColor = .yellow
        }
    }
    
    private func requestCast(tvShowId: Int) {
        networkManager.requestCastInfo(infoRequest: "/3/tv/", id: tvShowId, model: CastModel?.self) { response in
            self.castArr = response?.cast ?? []
            self.tvShowCastCollectionView.reloadData()
        }
    }
}
extension TVShowInfoViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        castArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = tvShowCastCollectionView.dequeueReusableCell(withReuseIdentifier: "MovieCastCell", for: indexPath) as? MovieCastCell {
            cell.setup(data: castArr[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: tvShowCastCollectionView.frame.height, height: tvShowCastCollectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextController = storyboard?.instantiateViewController(withIdentifier: "ActorInfoViewController") as! ActorInfoViewController
        nextController.id = castArr[indexPath.row].id!
        navigationController?.show(nextController, sender: nil)
    }
    
}
