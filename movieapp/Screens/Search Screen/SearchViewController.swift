//
//  SearchViewController.swift
//  movieapp
//
//  Created by Олександр Олійник on 16.06.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    var movieId: Int = 0
    
    let constants = Constants()
    
    let networkManager = NetworkManager()
    
    var listOfSearchingFilms: [SearchingMovie] = [ ]
    
    var listOfSearchingTVShows: [SearchingTVShow] = []
    
    var listOfSearchigActors: [SearchingActor] = []
    
    @IBOutlet weak var itemToSearch: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    // MARK: - Actions
    
    @IBAction func segmentChanged(_ sender: Any) {
        clearSearchTables()
    }
}

extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        switch(self.itemToSearch.selectedSegmentIndex) {
        case 0:
            //
            cell.setup(data: listOfSearchingFilms[indexPath.row])
        case 1:
            if (listOfSearchingTVShows[indexPath.row].poster_path != nil) {
                guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/original" + listOfSearchingTVShows[indexPath.row].poster_path!) else { return UICollectionViewCell() }
                cell.searchImage.sd_setImage(with: imageUrl)
            } else {
                cell.searchImage.image = UIImage(named: "no_image")
                cell.searchImage.contentMode = .scaleAspectFill
            }
        case 2:
            if (listOfSearchigActors[indexPath.row].profile_path != nil) {
                guard let imageUrl = URL(string: "https://image.tmdb.org/t/p/original" + listOfSearchigActors[indexPath.row].profile_path!) else { return UICollectionViewCell() }
                cell.searchImage.sd_setImage(with: imageUrl)
            } else {
                cell.searchImage.image = UIImage(named: "no_image")
                cell.searchImage.contentMode = .scaleAspectFill
            }
        default : return UICollectionViewCell() }
        
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //MARK: Switch search type
        switch(self.itemToSearch.selectedSegmentIndex) {
        case 0:
            return self.listOfSearchingFilms.count
        case 1:
            return self.listOfSearchingTVShows.count
        case 2:
            return self.listOfSearchigActors.count
        default : return 0 }
    }
    
    //MARK: Navigation to info page
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //MARK: Switch search type
        switch(self.itemToSearch.selectedSegmentIndex) {
        case 0:
            guard let nextController = storyboard?.instantiateViewController(withIdentifier: "MovieInfoViewController") as? MovieInfoViewController else { return }
            guard let transmittedId = listOfSearchingFilms[indexPath.row].id else { return }
            nextController.movieId = transmittedId
            navigationController?.show(nextController, sender: nil)
        case 1:
            guard let nextController = storyboard?.instantiateViewController(withIdentifier: "TVShowInfoViewController") as? TVShowInfoViewController else { return }
            guard let transmittedId = listOfSearchingTVShows[indexPath.row].id else { return }
            nextController.tvShowId = transmittedId
            navigationController?.show(nextController, sender: nil)
        case 2:
            guard let nextController = storyboard?.instantiateViewController(withIdentifier: "ActorInfoViewController") as? ActorInfoViewController else { return }
            guard let transmittedId = listOfSearchigActors[indexPath.row].id else { return }
            nextController.id = transmittedId
            navigationController?.show(nextController, sender: nil)
        default : return }
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = constants.screenHeight()/3
        let cellWidth = constants.screenWidth()/2.2
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchingText = searchText.replacingOccurrences(of: " ", with: "%20")
        search(name: searchingText.lowercased())
    }
    
    private func search(name: String) {
        switch(self.itemToSearch.selectedSegmentIndex) {
        case 0:
            networkManager.search(infoRequest: "/3/search/movie", nameOfMovie: name, model: SearchingMovieModel?.self) { result in
                self.listOfSearchingFilms = result?.results ?? []
                self.searchCollectionView.reloadData()
            }
        case 1:
            networkManager.search(infoRequest: "/3/search/tv", nameOfMovie: name, model: SearchingTVShowsModel?.self) { result in
                self.listOfSearchingTVShows = result?.results ?? []
                self.searchCollectionView.reloadData()
            }
        case 2:
            networkManager.search(infoRequest: "/3/search/person", nameOfMovie: name, model: SearchingActorModel?.self) { result in
                self.listOfSearchigActors = result?.results ?? []
                self.searchCollectionView.reloadData()
            }
        default: return }
    }
}
