//
//  OnboardingViewController.swift
//  movieapp
//
//  Created by Олександр Олійник on 12.06.2022.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var slides: [OnboardingSlide] = []
    
    @IBOutlet weak var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        createSlides()
    }
    
    private func createSlides() {
        self.slides.append(OnboardingSlide(image: UIImage(systemName: "tv.and.mediabox"), title: "Movie", description: " "))
        self.slides.append(OnboardingSlide(image: UIImage(systemName: "magnifyingglass"), title: "Search", description: "Search every movie or TV show you want"))
        self.slides.append(OnboardingSlide(image: UIImage(systemName: "list.bullet"), title: "Save", description: "Save movie or TV show you liked"))
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        pageControl.currentPage = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage.self = pageControl.currentPage
    }
    
    @IBAction func buttonPressed(_ sender: UIButton){
        let controller = storyboard?.instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: true)
    }
}
extension OnboardingViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as? OnboardingCollectionViewCell {
            cell.configureOnboardingSlide(data: slides[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        
    }
    
}
