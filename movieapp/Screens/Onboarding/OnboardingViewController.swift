//
//  OnboardingViewController.swift
//  movieapp
//
//  Created by Олександр Олійник on 12.07.2022.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var slides: [OnboardingSlideModel] = []
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK: - ViewControler LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSlides()
    }
    
    //MARK: - Private Funcs
    
    private func createSlides() {
        self.slides.append(OnboardingSlideModel(image: UIImage(systemName: "tv.and.mediabox"), title: "Movie", description: " "))
        self.slides.append(OnboardingSlideModel(image: UIImage(systemName: "magnifyingglass"), title: "Search", description: "Search every movie or TV show you want"))
        self.slides.append(OnboardingSlideModel(image: UIImage(systemName: "list.bullet"), title: "Save", description: "Save movie or TV show you liked"))
    }
    //MARK: Navigation to next page
    @IBAction func buttonPressed(_ sender: UIButton){
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "TabBar") as? UITabBarController else { return }
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        present(controller, animated: true)
    }
}
extension OnboardingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as? OnboardingCollectionViewCell {
            cell.configureOnboardingSlide(data: slides[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

extension OnboardingViewController: UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    //MARK: Page Control
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        pageControl.currentPage = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage.self = pageControl.currentPage
    }
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}

