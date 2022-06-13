//
//  ViewController.swift
//  movieapp
//
//  Created by Олександр Олійник on 11.06.2022.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var trendingMoviesArr: [TrendingMovie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestTrendingMovies()
        configureCollectionView()
      
    }
    
    
    private func requestTrendingMovies() {
        AF.request(Constants().url).responseJSON { result in
            let jsonDecoder = JSONDecoder()
            if let responseModel = try? jsonDecoder.decode(Result.self, from: result.data!) {
                self.trendingMoviesArr = responseModel.results!
                self.collectionView.reloadData()
            }
        }
    }
    private func configureCollectionView(){
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        self.collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.5).isActive = true
//        self.collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
//        self.collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
//        self.collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
}
extension MainViewController: UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingMoviesArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as? MainCollectionViewCell {
            cell.layer.cornerRadius = 10
            cell.setup(data: trendingMoviesArr[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 2.5, height: collectionView.frame.width / 2)
    }
}
