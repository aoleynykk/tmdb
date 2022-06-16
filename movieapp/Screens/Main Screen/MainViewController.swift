//
//  ViewController.swift
//  movieapp
//
//  Created by Олександр Олійник on 11.06.2022.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {

    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // configureCollectionView()
       
    }
    
    private func configureCollectionView(){
        
//        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//        self.collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 0.5).isActive = true
        
//        self.collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
//        self.collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
//        self.collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
}
extension MainViewController: UICollectionViewDataSource , UICollectionViewDelegate {
    
    func collectionView(_ trendingMoviesCollectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ trendingMoviesCollectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        cell.layer.cornerRadius = 10
        
        return cell
        
    }
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        CGSize(width: collectionView.frame.width / 2.5, height: collectionView.frame.width / 2)
//    }
}
